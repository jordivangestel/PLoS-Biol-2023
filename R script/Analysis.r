# van Gestel et al., 2023 PLoS Biology
# Script to determine expression changes in any of the genes in the count matrix (see also S5 Data)
# jordivangestel@gmail.com

rm(list=ls())
library(lmtest)

PATH  		<- getwd()
ANCESTOR_LABEL 	<- read.delim(paste0(PATH,"ANNOTATION_ANCESTOR.txt"),header=TRUE,sep="\t")	# Annotation of ancestral genome
REFERENCE_LABEL 	<- read.delim(paste0(PATH,"ANNOTATION_REFERENCE.txt"),header=TRUE,sep="\t")	# Annotation of reference genome in B. subtilis 168
COUNT			<- read.table(paste0(PATH,"COUNT_S5DATA.txt"),header=FALSE,sep="\t")		# Count data as shown in S5 Data
CONDITIONS 	 	<- read.table(paste0(PATH,"CONDITIONS.txt"),header=TRUE,sep="\t")			# Conditions
GENES			<- read.table(paste0(PATH,"GENES.txt"),header=FALSE,sep="\t")			# Genes
BBH			<- read.table(paste0(PATH,"BBH.txt"),header=TRUE,sep="\t") 				# Bi-directional best blast hits between ancestor and reference genome

COL 	  <- colorRampPalette(c("blue","red"),interpolate = c("linear"))
COL 	  <- COL(7)
color   <- COL[CONDITIONS$week+1]

# ADD GENE OF INTEREST: Here you can add any genes or operon of interest. As example, I now show the ric and rny genes associated with S5 Figure
# You can just use gene names used in the reference genome of B. subtilis, which are matched through bi-directional best blast hits with the ancestral genome in our study

G <- c("ricA","ricF","ricT","rny") 

pdf(paste0(PATH,"ANALYSIS.pdf"))

for(j in 1:2)
{
	if(j == 1){LINEAGE <- c(0,1);WEEKS<-c(0,5)} # compare ancestor to evolved colony lineage 1
	if(j == 2){LINEAGE <- c(0,2);WEEKS<-c(0,6)} # compare ancestor to evolved colony in lineage 2
	FIND_TAG	<- which(tolower(as.character(REFERENCE_LABEL$gene))%in%tolower(G))
	TAG         <- as.character(REFERENCE_LABEL$locus_tag[FIND_TAG])
	GENE        <- which(as.character(GENES[,1]) %in% as.character(BBH$locus_tag[which(BBH$match_locus_tag%in%TAG)]))
	
	SELECTION   <- which(CONDITIONS$location=="E"&CONDITIONS$lineage%in%LINEAGE&CONDITIONS$week%in%WEEKS)

	X           <- cbind(CONDITIONS$clone[SELECTION],CONDITIONS$day[SELECTION])
	Y           <- log2(as.numeric(colMeans(COUNT[GENE,SELECTION]))+1)		# Take average expression across all genes in operon
	D 		<- as.data.frame(cbind(X,Y))							# Data frame
	names(D)	<- c("clone","day","expression")
	D$clone  	<- as.factor(D$clone)
	D$day    	<- as.numeric(D$day)

	# Wald test: the default method can be employed for comparing nested (generalized) linear models (see details below)
	lm_full 		<- lm(expression~clone+day+clone*day,data=D)
	lm_interaction 	<- lm(expression~clone+day,data=D)
	lm_time 		<- lm(expression~clone,data=D)
	lm_genotype 	<- lm(expression~day,data=D)
	summ <- summary(lm_full)
	waldtest(lm_full,lm_interaction)		# compare statistical models
	waldtest(lm_interaction,lm_time)		# compare statistical models
	waldtest(lm_interaction,lm_genotype)	# compare statistical models
	
	plot(Y~X[,2],main=paste(G,collapse="_"),xlab="Time (days)",ylab="log2(counts+1)",cex=3,cex.axis=2,col=color[SELECTION],pch=16,xlim=c(1,7))
	for(i in 1:length(Y))
	{
		points(Y[i]~X[i,2],cex=3.8,pch=16,col=color[SELECTION[i]])
		points(Y[i]~X[i,2],cex=3.8,pch=1,col="white",lwd=2)
	}
	for(i in 1:length(LINEAGE))
	{
		SELECTION2 <- which(CONDITIONS$lineage[SELECTION]==LINEAGE[i])
		X1 <- CONDITIONS$day[SELECTION[SELECTION2]]
		Y1 <- log2(as.numeric(colMeans(COUNT[GENE,SELECTION[SELECTION2]]))+1)
		model1 <- lm(Y1~X1)
		model2 <- lm(Y1~1)
		model  <- which(BIC(model1,model2)[,2]==min(BIC(model1,model2)[,2]))
		if(model == 1) if(summary(model1)$coefficients[2,4]<0.05) abline(model1,col=color[SELECTION[SELECTION2]],lwd=3.8)
		if(model == 1) if(summary(model1)$coefficients[2,4]>0.05) model <- 2 # IF MODEL 1 IS NOT SIGNIFICANT PLOT THE SECOND (SIMPLER MODEL) WHEN SIGNIFICANT
		if(model == 2) if(summary(model2)$coefficients[1,4]<0.05) abline(model2,col=color[SELECTION[SELECTION2]],lwd=3.8)
	}
}	

for(j in 1:length(G))
{
	CLONE		<- c(1,3,6) # Compare ancestral and final evolved colonies in lineage 1 and 2
	SELECTION   <- which(CONDITIONS$location=="E"&CONDITIONS$clone%in%CLONE)
	TAG         <- as.character(REFERENCE_LABEL$locus_tag[which(tolower(as.character(REFERENCE_LABEL$gene))%in%tolower(G[j]))])
	GENE        <- which(as.character(GENES[,1]) %in% as.character(BBH$locus_tag[which(BBH$match_locus_tag%in%TAG)]))
	if(length(GENE)==1)
	{
		X           <- cbind(CONDITIONS$clone[SELECTION],CONDITIONS$day[SELECTION])
		Y           <- log2(as.numeric(colMeans(COUNT[GENE,SELECTION]))+1)
		D 		<- as.data.frame(cbind(X,Y))
		names(D)	<- c("clone","day","expression")
		D$clone  	<- as.factor(D$clone)
		D$day    	<- as.numeric(D$day)
		D		<- D[c(which(D$clone=="1"),which(D$clone=="3"),which(D$clone=="6")),]
	
		WILCOX 	<- pairwise.wilcox.test(D$expression,D$clone,p.adjust.method="BH")
		ROW  		<- paste(D$clone,D$day)
		days 		<- unique(D$day)
		plot(c(0,(length(CLONE)*length(days)+0.5)),c(min(D$expression),max(D$expression)+1),type="n",xlab="Ancestor   /   Lineage 1   /   Lineage 2",ylab="log2(counts+1)",xaxt='n',frame.plot=FALSE,cex.axis=1.5,main=G[j])
		x_cor		<- c()
		for(i in 1:length(CLONE))for(d in 1:length(days))
		{
			n <- which(D$clone==CLONE[i]&D$day==days[d])
			x <- 0.2+i*length(days)*1.1-5+d
			x_cor <- c(x_cor,x)
			rect(x-0.4,min(D$expression),x+0.4,mean(D$expression[n]),col="white",border=COL[days[d]],lwd=2)
			points(rep(x,each=3),D$expression[which(D$clone==CLONE[i]&D$day==days[d])],col=COL[days[d]],pch=1,lwd=2,cex=3.5)
		}
		axis(1,at=x_cor,labels=paste0("Day ",rep(days,time=3)),las=2)
	}
}

dev.off()
