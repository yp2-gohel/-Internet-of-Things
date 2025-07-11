# Worksheet 1 – Process Documentation

## Development Process

1. **Project Setup:** I began by reviewing the project requirements and organizing the folder structure, ensuring all source, test, and data directories were in place.
2. **Simulated GPS Device:** I implemented the `GPSSensor` class to read GPS data from CSV files and output formatted readings. I validated the CSV parsing and data storage logic.
3. **eBike Client Application:** I developed the `ebikeClient.cpp` to use the `GPSSensor`, print location data, and simulate device attach/release events.
4. **Unit Testing:** I integrated the Catch2 framework, created comprehensive tests for `GPSSensor` and client logic, and updated the Makefile to automate test builds and execution.
5. **Cross-Platform Build:** I adapted the Makefile and code to work on Windows, handling differences in file paths and library linking.

## Main Challenges & Solutions

- **Header/Linker Issues:** I initially faced issues with the Catch2 header and multiple definitions of `CATCH_CONFIG_MAIN`. I resolved this by using the official Catch2 header and combining all tests into a single file.
- **Windows Compatibility:** Adapting the Makefile and file paths for Windows required careful handling of compiler flags and directory separators. I used MSYS2 and ensured all dependencies were correctly referenced.
- **Data Parsing Robustness:** Handling malformed or missing CSV lines was tricky. I used exception handling to skip invalid lines without crashing the program.

## Key Learnings

- **Test-Driven Development:** Writing unit tests early helped me catch bugs and clarify requirements, leading to more reliable code.
- **Cross-Platform C++ Development:** I learned how to adapt build systems and code for both Linux and Windows environments, which improved my understanding of portability challenges.
- **Effective Debugging:** Systematic debugging and incremental changes were crucial, especially when dealing with build and linking errors.
- **Documentation and Clean Code:** Keeping code well-documented and maintaining a clear project structure made development and testing much smoother.

Overall, this worksheet enhanced my skills in C++ development, unit testing, cross-platform builds, and systematic problem-solving.
