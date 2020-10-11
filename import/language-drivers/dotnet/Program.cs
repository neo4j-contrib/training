using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Neo4j.Driver;

namespace dotnet
{
    class Program
    {
        static async Task Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.WriteLine("Usage:dotnet run name1 name2");
                System.Environment.Exit(1);
            }

            using (var driver = GraphDatabase.Driver("bolt://localhost:7687",
                            AuthTokens.Basic("neo4j", "neo")))
            {

                var session = driver.AsyncSession(o => o.WithDatabase("neo4j"));
                    var result = await session.WriteTransactionAsync(async tx =>
                    {
                        var cypherQuery = "MERGE (p1:Person {name: $person1 }) MERGE (p2:Person {name: $person2 }) MERGE (p1)-[:KNOWS]->(p2)";
                        var r = await tx.RunAsync(cypherQuery,
                                new { person1 = args[0], person2 = args[1] });
                        var summary = await r.ConsumeAsync();
                        return summary.Counters;
                    });

                await session?.CloseAsync();
                Console.WriteLine(result);
            }
        }
    }
}