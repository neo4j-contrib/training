# Neo4j Case Studies - Glassdoor

![](https://vimeo.com/album/2584141)

##Background
----------
Glassdoor is a company that provides anonymized inside information to help job seekers to more effectively work their extended networks to get jobs.

##Business Problem
----------------
Most jobs are found through personal connections. The goal of this system was to allow people to import their facebook network to provide them with access to information on interesting jobs more efficiently.

##Solutions and Benefits
----------------------
Glassdoor built a "first to market" solution for helping people to find jobs via their Facebook friends. Individual Facebook graphs are imported in real time into Neo4j and Glassdoor now stores >50% of the entire Facebook social graph. The Neo4j cluster has grown seamlessly, with new instances being brought online as graph size and load have increased.