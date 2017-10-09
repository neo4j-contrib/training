using System;
using Neo4j.Driver.V1;
using System.Collections.Generic;

namespace dotnet
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine("Usage:dotnet run [Person1] [Person]");
                System.Environment.Exit(1);
            }

            using (var driver = GraphDatabase.Driver("bolt://localhost:7687", AuthTokens.Basic("neo4j", "neo")))
            using (var session = driver.Session())
            {
                var result = session.Run("MERGE (p1:Person {name: {person1} }) MERGE (p2:Person {name: {person2} }) MERGE (p1)-[:KNOWS]->(p2)",
                    new Dictionary<string, object> { { "person1", args[0] }, { "person2", args[1] } });

                Console.WriteLine(result.Summary.Counters);
            }
        }
    }
}
