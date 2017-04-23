# Notes: History of Graph Theory

When we’re talking about Graphs, we’re talking about a representation of information, rooted in mathematical theory. Not about charts or diagrams.

So... to talk about Graphs, it’s helpful to understand history.

## Leonhard Euler

Let me introduce [**Leonhard Euler**](http://en.wikipedia.org/wiki/Leonhard_Euler), a Swiss mathematician, who invented most of modern mathematical terminology and notation (like the notion of functions), and pioneered graph theory.

----

![](../images/euler.png)

----

Euler lived in Königsberg for a while, and in 1736 he created and solved the problem known as the 
[**7 Bridges of Königsberg**](http://en.wikipedia.org/wiki/Seven_Bridges_of_Königsberg). 

![7 Bridges of Königsberg](../images/koenigsberg.png "7 Bridges of Königsberg")

The problem is to decide whether it is possible to follow a path that crosses each of the 7 bridges exactly once and return to the starting point. This problem was the first study of graph theory.

![](../images/slides_kb_01.png)
Königsberg was divided into multiple areas bythe Pregel river, and the 7 bridges joined the different city areas together.

![](../images/slides_kb_02.png)
Euler first identified these 4 land masses...

![](../images/slides_kb_03.png)
... and pointed out that the choice of route inside each of the 4 city areas was irrelevant to the problem.

![](../images/slides_kb_03.png)
Euler then went further, and realized that position, size or any other feature of the bridge didn’t matter - except for which two land masses it connected.

![](../images/slides_kb_05.png)
With these two understandings, Euler eliminated all features all features except the list of land masses and the bridges connecting them. In modern terms, one replaces each land mass with an abstract "vertex", and each bridge with an abstract connection, an"edge".

###This resulting structure is called a graph.###

![](../images/kb_graph.png)
For normal humans (not mathematicians) we find it easier to use the terms Node and Relationship. 