# order_app
 This Flutter project focuses on creating an order management application.
 Here's an overview of what I've done:

**State Management**: I've utilized GetX for state management.
**UI Design**: The UI is designed to be professional with specific color schemes (AppColors) and an organized layout using Flutter's widgets (Column, Row, ListView, Stack, etc.).
 The whole design is according to the requirements of The given design(Figma). 
**API Integration**: Fetched data from API.
**Quality**: The project code is clean, maintained, and well-documented.
**Responsiveness**: The project is developed so that the UI is responsive and looks good on different screen sizes.
**Product List/Table**: Displayed a list/table where users can input product details.
o Each row has fields for 'Product Name' and 'Quantity'.
o Users can add as many rows as they want. For that, **I created a floating button by which a new row can be generated.**
o Implemented an autocomplete feature for the 'Product Name' field to suggest products as the user types, and this data is fetched from API.
o Fetched the list of products from the provided API.
o Users can type the product name manually or select from the autocomplete list.
**Dynamic Button States**:
o Included 'arrow forward' icon by which you can navigate to the next screen and the data the user entered will display as a list.
o Initially, this button is disabled.
o  The button will only be enabled when at least one row is filled in the table.
**Autocomplete**: Integrated autocomplete functionality for product names (Autocomplete widget) to assist users in selecting products efficiently.
**Add Notes and Images:**
o Implemented a function so that when a user double-taps (or long-presses) on a row
where a product name is typed, a modal will open.
o The modal will allow the user to write notes and select images.
o If notes are written, it will display an info icon in that row.
o If an image is selected, it will display a camera icon in that row.
To do this when the user enters the data of the product(quantity  and name)  as much user wants and then presses the arrow forward icon this will navigate the user to a preview screen and then by long pressing or by double tapping the row in which data is showing it will show a camera icon if the image is selected or info icon when a note is entered or both can show.
