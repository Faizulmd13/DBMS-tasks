// Connect to MongoDB
const MongoClient = require('mongodb').MongoClient;
const uri = 'mongodb://localhost:27017/mydb';
const client = new MongoClient(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

client.connect(async err => {
  if (err) throw err;

  // Get the database
  const db = client.db('mydb');

  // Create a document in the 'users' collection
  const usersCollection = db.collection('users');
  const newUser = { name: 'John Doe', age: 30, email: 'john@example.com' };

  const result = await usersCollection.insertOne(newUser);
  console.log(`Inserted document with _id: ${result.insertedId}`);

  // Close the connection
  client.close();
});
