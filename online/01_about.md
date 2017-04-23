## About this Course

We've been running the "Intro to Neo4j" training more than a hundred times and are getting a lot of requests for more re-runs of this full day training class. Unfortunately we cannot accommodate all the requests, especially for locations where only a few people sign up.

On the other hand many people cannot afford to stay a full day away from work and would rather learn about Neo4j on their own time or with their personal pace.

Creating an online version of the class and making it available to everyone will satisfy your thirst for knowledge and allow us to get a quick feedback loop. **Please** give us [feedback](mailto:training@neotechnology.com) on how we can improve it.

Feel free to pause and resume the course whenever you wish. You can re-login, by just entering your email address in the login form.

### How does the course work?
We structured the course into multiple lessons, each meant for about 2 hours, so easily worked through in an evening.

####These lessons are:
1. Intro to Graph Databases and Neo4j
2. Introduction to Cypher - Graph Query Language
3. Creating and Editing Graphs using Cypher
4. Neo4j in Practice

You can access the lessons and individual sections via the course menu on the left or on the top left (for narrow screens).

Within the lessons we provide information in different ways:

* as entertaining video lectures with our ingenious course **host Andreas Kollegger**
* as explaining text with **highlighted syntax examples**
* as **slideshows** that present material from the full-day course
* and as a special treat, with an interactive query widget, called the **Cypher Query Gadget**, that you can use to interactively try and learn the concepts of **Cypher** our graph query language

### The Cypher Query Gadget

This gadget is there for you to interactively explore, learn and get comfortable with Cypher in a safe environment. You can't break anything, and if so, just reset the temporary database to its original state.

The different gadgets use different datasets, depending on the task, but save your changes across sessions. For most lab exercises we added helpful checks and messages to guide you along. 

The query results are shown in a tabular view, and if you return nodes or relationships, those will be highlighted in the graph visualization of the dataset. Complex elements are folded in the table and can be expanded with a click.

Your history is available across sessions. And we provide some pre-canned queries to get you  started quickly. 

Please try to work with the tasks on your own and not just copy & paste queries. Thinking about them and writing & executing them incrementally helps you much more in understanding the concepts.
** **

![Cypher Widget Explanation](../images/cypher_console_explain.png "Cypher Widget Explanation")

## The Movies & Actors Graph Data Model

The data model that we'll use throughout this course should be easy to understand. The goal is to learn about graphs and Cypher and not about a new <a href="http://bit.ly/1b70TJp" target="_blank">domain</a> . To learn about the elements in the graph, please have a look at the picture below.

The dataset contains:

* __movies__ with a *:Movie* label and *title, released* and *tagline* properties
* __people__ with a *:Person* label and *name* and *born* properties
* an *ACTED_IN* relationship from actors to movies, with a *roles* property that contains a list of character names
* a *DIRECTED* relationship from directors to movies

![Domain Model](../images/domain_model.png "Please make sure to have this model at hand when working with the course, you'll need it often.")
