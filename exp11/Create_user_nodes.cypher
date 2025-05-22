// Create a node
CREATE (user:User { name: 'John Doe', age: 30, email: 'john@example.com' });

// Create another node
CREATE (friend:User { name: 'Jane Smith', age: 28, email: 'jane@example.com' });

// Create a relationship between nodes
MATCH (u:User { name: 'John Doe' }), (f:User { name: 'Jane Smith' })
CREATE (u)-[:FRIEND]->(f);
