
###################################################
## Author:  Yanchang Zhao
## Email:   yanchang@RDataMining.com
## Website: http://www.RDataMining.com
## Date:    July 2019
###################################################

## load required packages
library(magrittr) ## for pipe operations
library(ggplot2)
library(igraph)
library(visNetwork)


## ----------------------- Graph Construction -----------------------
library(igraph)
# nodes
nodes <- data.frame(
  name = c("Tom","Ben","Bob","John","Mary","Alice","Wendy","David"),
  gender = c("M", "M", "M", "M", "F", "F", "F", "M"),
  age =    c( 16,  30,  42,  29,  26,  32,  18,  22)
)
# relations
edges <- data.frame(
  from = c("Tom", "Ben",  "Bob", "Mary", "Alice", "Wendy", "Wendy"), 
  to  =  c("John", "John", "John", "John","Mary", "Mary", "David")
)
# build a graph object
g <- graph.data.frame(edges, directed=F, vertices=nodes)
layout1 <- g %>% layout_nicely() ## save layout for reuse
g %>% plot(vertex.size=30, layout=layout1)
## use blue for male and pink for female
colors <-  ifelse(V(g)$gender=="M", "skyblue", "pink")
g %>% plot(vertex.size=30, vertex.color=colors, layout=layout1)


## ----------------------- Graph Query -----------------------
## nodes
V(g)
## edges
E(g)
## immediate neighbors (friends) of John
friends <- ego(g,order=1,nodes="John",mindist=1)[[1]] %>% print()
## female friends of John
friends[friends$gender == "F"]
## 1- and 2-order neighbors (friends) of John
g2 <- make_ego_graph(g, order=2, nodes="John")[[1]]
g2 %>% plot(vertex.size=30, vertex.color=colors)


## ----------------------- Centrality Measures -----------------------
g %>% plot(vertex.size=30, vertex.color=colors, layout=layout1)
degree <- g %>% degree() %>% print()
closeness <- g %>% closeness() %>% round(2) %>% print()
betweenness <- g %>% betweenness() %>% print()
eigenvector <- evcent(g)$vector %>% round(2) %>% print()
transitivity <- g %>% transitivity(type="local") %>% print()


## ----------------------- Advanced Graph Visualization -----------------------
## ## download graph data
## url <- "http://www.rdatamining.com/data/graph.rdata"
## download.file(url, destfile="./data/graph.rdata")
library(igraph)
# load graph data into R
# what will be loaded: g, nodes, edges
load("../data/graph.rdata") 
head(nodes, 3)
head(edges, 3)
## buid a graph object
g <- graph.data.frame(edges, directed=F, vertices=nodes)
g
library(igraph)
plot(g, vertex.size=12, vertex.label.cex=0.7, 
     vertex.color=as.factor(V(g)$type), vertex.frame.color=NA)
## library(visNetwork)
## V(g)$group <- V(g)$type
## ## visualization
## data <- toVisNetworkData(g)
## visNetwork(nodes=data$nodes, edges=data$edges) %>%
## visGroups(groupname="tid",shape="icon",icon=list(code="f15c")) %>%
## visGroups(groupname="person",shape="icon",icon=list(code="f007")) %>%
## visGroups(groupname="addr",shape="icon",icon=list(code="f015")) %>%
## visGroups(groupname="phone",shape="icon",icon=list(code="f095")) %>%
## visGroups(groupname="email",shape="icon",icon=list(code="f0e0")) %>%
## addFontAwesome() %>%
## visLegend()
