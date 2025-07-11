CXX = g++
CXXFLAGS = -std=c++17 -Wall -I./src -I./src/sensor -I./src/comm
SRC_DIR = src
OBJ_DIR = build
BIN_DIR = bin

EBIKECLIENT_SRC = $(SRC_DIR)/ebikeClient.cpp
EBIKECLIENT_OBJ = $(OBJ_DIR)/ebikeClient.o
EBIKECLIENT_BIN = ebikeClient

EBIKEGATEWAY_SRC = $(SRC_DIR)/ebikeGateway.cpp
EBIKEGATEWAY_OBJ = $(OBJ_DIR)/ebikeGateway.o
EBIKEGATEWAY_BIN = ebikeGateway

SOCKETSERVER_SRC = $(SRC_DIR)/comm/SocketServer.cpp
SOCKETSERVER_OBJ = $(OBJ_DIR)/SocketServer.o
MESSAGEHANDLER_SRC = $(SRC_DIR)/comm/MessageHandler.cpp
MESSAGEHANDLER_OBJ = $(OBJ_DIR)/MessageHandler.o

SENSOR_SRC = $(SRC_DIR)/sensor/GPSSensor.h

# Libraries for webserver and simnet (Linux/CSCTCloud)
ifeq ($(OS),Windows_NT)
    LDFLAGS = -L/ucrt64/lib -lPocoNet -lPocoUtil -lPocoFoundation -lPocoJSON -lpthread
    CXXFLAGS += -I/ucrt64/include
else
    LDFLAGS = -L/opt/iot/lib -lwebserver -lsimnet -lPocoJSON -lPocoFoundation -lpthread
endif

all: $(EBIKECLIENT_BIN) $(EBIKEGATEWAY_BIN)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(EBIKECLIENT_OBJ): $(EBIKECLIENT_SRC) $(SENSOR_SRC) | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $(EBIKECLIENT_SRC) -o $(EBIKECLIENT_OBJ)

$(EBIKECLIENT_BIN): $(EBIKECLIENT_OBJ)
	$(CXX) $(CXXFLAGS) $(EBIKECLIENT_OBJ) -lws2_32 $(LDFLAGS) -o $(EBIKECLIENT_BIN)

$(SOCKETSERVER_OBJ): $(SOCKETSERVER_SRC) | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $(SOCKETSERVER_SRC) -o $(SOCKETSERVER_OBJ)

$(MESSAGEHANDLER_OBJ): $(MESSAGEHANDLER_SRC) | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $(MESSAGEHANDLER_SRC) -o $(MESSAGEHANDLER_OBJ)

$(EBIKEGATEWAY_OBJ): $(EBIKEGATEWAY_SRC) | $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $(EBIKEGATEWAY_SRC) -o $(EBIKEGATEWAY_OBJ)

$(EBIKEGATEWAY_BIN): $(EBIKEGATEWAY_OBJ) $(SOCKETSERVER_OBJ) $(MESSAGEHANDLER_OBJ)
	$(CXX) $(CXXFLAGS) $^ -lws2_32 $(LDFLAGS) -o $@

# Test build target (single combined test file)
TESTS_DIR = tests
ALL_TESTS_SRC = $(TESTS_DIR)/all_tests.cpp
CATCH_HEADER = $(TESTS_DIR)/catch.hpp
ALL_TESTS_BIN = all_tests.exe

$(ALL_TESTS_BIN): $(ALL_TESTS_SRC) $(SRC_DIR)/sensor/GPSSensor.h $(CATCH_HEADER)
	$(CXX) $(CXXFLAGS) $< -o $@

.PHONY: test

test: $(ALL_TESTS_BIN)
	./$(ALL_TESTS_BIN)

clean:
	rm -rf $(OBJ_DIR) $(EBIKECLIENT_BIN) $(EBIKEGATEWAY_BIN) $(ALL_TESTS_BIN)
