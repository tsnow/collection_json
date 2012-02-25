#1.2. Query Templates
#Clients that support the Collection+JSON media type SHOULD be able to recognize and parse query templates found within responses. Query templates consist of a data array associated with an href property. The queries array supports query templates.

#For query templates, the name/value pairs of the data array set are appended to the URI found in the href property associated with the queries array (with a question-mark ["?"] as separator) and this new URI is sent to the processing agent.
describe CollectionJson::Query do

end
