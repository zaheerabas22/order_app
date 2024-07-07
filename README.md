# order_app

## Overview

This Flutter project focuses on creating an order management application. Here's an overview of what I've done:

### State Management
- Utilized GetX for efficient state management.

### UI Design
- Designed a professional UI with specific color schemes (AppColors) and an organized layout using Flutter's widgets (Column, Row, ListView, Stack, etc.).
- The design adheres to the requirements specified in Figma designs.

### API Integration
- Integrated API to fetch product data dynamically.

### Quality
- Maintained clean and well-documented code for better readability and maintainability.

### Responsiveness
- Developed the UI to be responsive, ensuring a seamless experience across different screen sizes.

### Product List/Table
- Implemented a dynamic list/table where users can input product details like 'Product Name' and 'Quantity'.
- Users can add new rows dynamically using a floating button.
- Incorporated autocomplete functionality for the 'Product Name' field, suggesting products based on API data.

### Dynamic Button States
- Included an 'arrow forward' icon for navigation to the next screen.
- Initially disabled, the button becomes enabled once at least one row in the table is filled.

### Autocomplete
- Integrated autocomplete for product names to facilitate quick selection by users.

### Add Notes and Images
- Implemented functionality where users can add notes and images to product entries.
- Users can open a modal by double-tapping or long-pressing on a row where a product name is entered.
- The modal allows writing notes and selecting images, displaying corresponding icons (info or camera) in the row based on user actions.

## Usage
To use the application:
1. Enter product details (quantity and name) in the table.
2. Navigate to the preview screen using the 'arrow forward' icon.
3. Double-tap or long-press on a row to add notes or select images.

This project aims to provide a comprehensive solution for managing orders efficiently. For any inquiries or issues, please feel free to contact me.
