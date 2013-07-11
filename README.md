Survey Mobile iOS Native
========================
An application to conduction dynamic surveys using iOS device. Backed by API from rails server ([web survey app](https://github.com/nilenso/ashoka-survey-web)). This application is built using Rubymotion framework to create native iOS app.

[![Code Climate](https://codeclimate.com/github/multunus/survey_app_ios_client.png)](https://codeclimate.com/github/multunus/survey_app_ios_client)

Dependencies
------------

- [NanoStoreInMotion](https://github.com/siuying/NanoStoreInMotion)
- [BubbleWrap](https://github.com/rubymotion/BubbleWrap)
- [SugarCube](https://github.com/rubymotion/sugarcube)
- [Promotion](https://github.com/clearsightstudio/ProMotion)
- [TeaCup](https://github.com/rubymotion/teacup)


How it works
------------
You need to have Rubymotion setup. Current app lists all the surveys available load through a JSON file. Yet to integrate the app to actual APIs. All the data is saved into local database (lightweight schema-less local key-value document store - NanoStore).

Initial data is loaded from json files. You need to update JSON file to add your own surveys. 

The typical flow about how to use this application is:
1.  You can select any survey question listed.
2.  Fill the survey by swiping through each question.
3.  Currently supported question types are:
    *   Multi-record - It creates extra fields on the fly once you selct an answer from a multi choice questions 
    *   Radio - It renders set of radio buttons by taking answer options.
    *   Checkbox - It renders question which contains multiple checkboxes with the options. you can select multiple answers.
    *   Text box - A simple text field to collect single line answers
    *   Textarea - A multiline text field to collect a brief description or explanation
4.  Questions can be marked mandatory.
5.  Form will be validated before completion.
6.  Filled forms can be saved to see the list of completed responses.

To Do
-----
* Save as draft
* Multi record with multiple questions
* Integrate into actual API (rails server)

Contributing
------------
1.  Fork it
2.  Create your feature branch (git checkout -b my-new-feature)
3.  Commit your changes along with the tests (git commit -am 'Add some feature')
4.  Push to the branch (git push origin my-new-feature)
5.  Create new Pull Request
