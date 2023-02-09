HOMEWORK PROJECT #2: Parsing for a Conversational Assistant

Group 15:
Ahmed 23PGAI0120
Akash Deshwani 23PGAI0035
Harshada Suresh Jadhav 23PGGAI0101
Rohan Mehta 23PGAI0001

The ultimate goal of this project is to build a prototype talking, interactive cookbook.

We have split the project into 2 parts: UI App, and backend code

UI App:
We have used the Tkinter library which is the standard GUI library for Python. There are 3 text boxes:
1. Textbox 1: User input for recipe requirement. It opens the website www.allrecipes.com and enters the input in the search box, and selects the first search suggestion. The webpage is scraped using BeautifulSoup and function is called to parse the recipe (discussed in detail in the backend section)
2. Textbox 2: User input for query. Here are a few example questions: You can ask these kind of questions., What are the ingredients required for this recipe?, What are the steps to be followed for this recipe?, What are the tools required for this recipe?, What is the preparation time for this recipe?, What is the cooking time for this recipe?, What is the aditional time for this recipe?, What is the total time for this recipe?, How many people does this recipe serve?, Mention all temperatures, What is the previous step of place pork sections?, What is the next step of place pork sections?, What is the quantity of chinese rice wine?, What is the quantity of rice wine?, What is the quantity of wine?, What is the quantity of chinese rice wine?
3. Textbox 3: This gives the answer to the question. There is a refresh button, that clears the textbox, and shows a list of possible questions.

Backend Code:
We have functions:
1. get_recipe_name: Gets the recipe name from the URL
2. scrape_web_page: Scrapes the webpage using BeautifulSoup
3. get_ingredients: Scrapes the ingredients from the wepbpage
4. get_steps: Scrapes the steps from the wepbpage
5. get_tools: Gets the tools from the steps
6. get_temp: Get all the steps which mentions temperature
7. get_quantity: Gets quantity for input ingredient
8. get_previous: Gets previous step to user step input
9. get_next: Gets next step to user input
10. get_prep_time: Gets preparation time from the webpage
11. get_cook_time: Gets cooking time from the webpage
12. get_additional_time: Gets additional time drom the webpage
13. get_total_time: Gets total time from the webpage
14. get_servings: Get servings from the webpage

We have also explored text to speech reading, but were not able to get it working perfectly so left it out of the code