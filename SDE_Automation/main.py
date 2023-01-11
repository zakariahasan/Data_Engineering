import os
from xml.etree import ElementTree as ET

# Define the source and destination paths
source_path = r"C:\Users\Name\Folder"
destination_path = r"C:\Users\Name\Destination Folder\output.xml"

# Initialize an empty list to store the child elements
child_elements = []

# Loop through all the files in the source directory
for filename in os.listdir(source_path):
    # Check if the file is an XML file
    if filename.endswith('.config'):
        # Parse the XML file
        tree = ET.parse(os.path.join(source_path, filename))
        root = tree.getroot()
    # Loop through each child element of the root
    for child in root:
        for systems in child:
            child_elements.append(systems)

##########################################################################
# Create the root element
root = ET.Element("configuration")
root.set("version", "5")

# Create the messagesTransfer element
messagesTransfer = ET.SubElement(root, "messagesTransfer")
messagesTransfer.set("enabled", "true")
messagesTransfer.set("deleteFiles", "false")
messagesTransfer.set("onlyLocal", "false")
messagesTransfer.set("notifyManualExtract", "true")

# Create the localPath element
localPath = ET.SubElement(messagesTransfer, "localPath")
localPath.text = "Messages\\"

# Create the sftpPath element
sftpPath = ET.SubElement(messagesTransfer, "sftpPath")
sftpPath.text = "Messages\\"

# Create the instanceName element
instanceName = ET.SubElement(messagesTransfer, "instanceName")
instanceName.text = "Template"

# Create the lastAliveSent element
lastAliveSent = ET.SubElement(messagesTransfer, "lastAliveSent")
lastAliveSent.text = "2012-08-22T10:52:32"

# Create the aliveCheckHour element
aliveCheckHour = ET.SubElement(messagesTransfer, "aliveCheckHour")
aliveCheckHour.text = "1"

# Create the configurationUpdate element
configUpdate = ET.SubElement(root, "configurationUpdate")
configUpdate.set("automaticUpdate", "false")
configUpdate.set("automaticSending", "true")
configUpdate.text = "1"
# Create the systems element
systems = ET.SubElement(root, "systems")

# Create the system element

for child in child_elements:
    if child.tag == "system":       
        systems.append(child)

# Write the XML tree to a file
tree = ET.ElementTree(root)
tree.write(destination_path, encoding="UTF-8")
