{\rtf1\ansi\ansicpg1252\cocoartf1343\cocoasubrtf140
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural

\f0\fs24 \cf0 Steps for setting up server:\
1. Unzip server \
2. Import it into eclipse\
3.  Create a new Tomcat V7 server and add the module \'93COMP4601A1-100865217\'94 and make the path of the web module to be \'93/COMP4601SDA\'94\
5. Make sure mongodb is running\
4. Run the server on port 8080\
\
\
Steps for setting up client:\
1. Unzip client\
2. Open COMP4601A1-100865217.xcodeproj in Xcode\'92\
3. Run the app\
\
\
How to test:\
1. Any GET requests can be tested by visiting http://localhost:8080/COMP4601SDA/rest/sda/\{URL\}\
\
2. How to test question 4:\
\
4.1: Open app, press \'93Create Document\'94, enter information and press submit\
4.2: The document you just created should appear in the list, click it.  Now press \'93Edit\'94 at the top right.  You can now edit any information about the document.  Upon pressing save, the information will be updated on screen.\
4.3: Go to main screen, enter the ID of the document that you wish to search by in the first text box and press \'93Search\'94.  It will appear in the list at the bottom.\
4.4: Go to main screen, enter the ID of the document that you wish to delete in the third text box and press \'93Delete\'94.  A success message will appear in a popup.  After this, try searching by the id you deleted and it will no longer be in the list.\
4.5: Go to main screen, enter the tags of the documents that you wish to delete, separated by semicolons, in the forth text box and press \'93Delete\'94. A success message will appear in a popup.  After this, try searching by the tag you deleted and it will no longer be in the list.\
4.6: Enter the tags you wish to search for in the second text box separated by semicolons.  The found documents will appear in the list at the bottom.  Click on a document to view it\'92s contents.\
4.7: Any document in the list can be clicked on\
4.8:  Press view all documents at the bottom right\
}