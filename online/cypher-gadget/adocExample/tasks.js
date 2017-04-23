//mount gadgets with respective tasks on page load
$(function () {
  //Example 1:
  renderGadget('#ex1', {
      label: 'Gadget 1',
      cypherSetup: "lesson1",
      task: {
        message: "Adding 'Mystic River'",
        tasks: [
          {
            "check": "input",
            "test": ":Movie",
            "failMsg": "You probably want to use the :Movie label"
          },
          {
            "check": "input",
            "test": "title",
            "failMsg": "There should be a title property in your query"
          },
          {
            "check": "input",
            "test": "Mystic River",
            "failMsg": "This movie is titled 'Mystic River'"
          },
          {
            "check": "output",
            "test": "Mystic River",
            "failMsg": "It makes sense to return the movie too. For validation"
          }
        ]
      }
    }
  );

  //Example 2:
  renderGadget('#ex2', {
    label: 'Gadget 2',
    cypherSetup: "full",
    task: {
      message: "Delete Emil and his relationships",
      tasks: [
        {
          "check": "input",
          "test": ":Person",
          "failMsg": "You'll want to start at nodes labeled Person"
        },
        {
          "check": "input",
          "test": "name.+Emil Eifrem",
          "failMsg": "You probably want to check the name property for 'Emil Eifrem'"
        },
        {
          "check": "input",
          "test": "OPTIONAL\\s+MATCH",
          "failMsg": "Remember not only to delete Emil but also to match his potential relationships and delete them."
        },
        {
          "check": "input",
          "test": "\\[\\w+\\]",
          "failMsg": "You probably wanted to assign an identifier to your relationship"
        },
        {
          "check": "input",
          "test": "DELETE",
          "failMsg": "You most probably want to DELETE Emil and his relationships"
        }
      ]
    }
  });
});
