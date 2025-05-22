from lxml import etree

# Load the XML document
try:
    xml_doc = etree.parse('library.xml')
except Exception as e:
    print("Failed to parse XML:", e)
    exit()

# Load and compile the XML Schema
try:
    xml_schema = etree.XMLSchema(file='library.xsd')
except Exception as e:
    print("Failed to parse XSD:", e)
    exit()

# Validate the XML document against the schema
is_valid = xml_schema.validate(xml_doc)

if is_valid:
    print("✅ XML document is valid.")
else:
    print("❌ XML document is invalid.")
    print(xml_schema.error_log)

