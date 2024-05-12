# Code Architecture

In this project, the Redux architecture is utilized due to its advantages, including a modular and extensible structure, enhanced testability, and seamless integration with tools like ChatGPT or other GPT models for comprehensive code coverage.

While alternative state management solutions like bloc/cubit/getx combined with a clean architecture could have been employed, Redux offers a distinct advantage through its visual debugger accessible at localhost:8000. This debugger provides a comprehensive view of the application's state and function invocations, expediting the debugging process and facilitating better control over the development workflow.

![Debugger example](https://miro.medium.com/v2/resize:fit:828/format:webp/1*BWEFUQz688hbqbZ_8CdNeA.png)


Furthermore, Redux boasts a well-defined data flow, progressing from actions to the store, which minimizes the likelihood of side effects, contributing to a more predictable and maintainable codebase.


# Project Structure
There are three main folders in the /lib project: core, functions, pages.

## Core Folder
The `/lib/core` folder is responsible for storing code that is used throughout the project, forming the core for features and pages. It contains project configuration, constants, and common widgets also known as UI kit.

## Features Folder
The `/lib/features` folder handles the business logic and data management of the project. It contains code that regulates how data is "fetched -> processed -> stored".

## Pages Folder
The `/lib/pages` folder is responsible for rendering pages to the end-user. Each page contains only the display of ready-made widgets and their layout on the screen. The individual elements are stored either in `/lib/core/ui_kit` or in the `/lib/pages/page1/widgets` folder alongside the page file if they are specific to that page and not used elsewhere. Files with the `page` extension should not contain BlocBuilder, StoreBuilder, or other builders that update the page. Builders are stored in the widget files of the respective page. In other words, pages are the top of the pyramid where the widget hierarchy is assembled as follows: `ui_kit -> widgets -> pages`.


## Project Settings
To maintain consistent code formatting, a line length of 100 characters should be adhered to throughout the project.<br>
The debugger is disabled in the project release since its installation requires additional time.