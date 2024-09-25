# Directories
BIN_DIR := bin
CMD_DIR := cmd

# Microservices' names
MICROSERVICE_CARBS := carbs
MICROSERVICE_DAIRY := dairy
MICROSERVICE_VEGETABLES := vegetables
MICROSERVICE_MEATS := meats

# Binaries
CARBS_BIN := $(BIN_DIR)/$(MICROSERVICE_CARBS)
DAIRY_BIN := $(BIN_DIR)/$(MICROSERVICE_DAIRY)
VEGETABLES_BIN := $(BIN_DIR)/$(MICROSERVICE_VEGETABLES)
MEATS_BIN := $(BIN_DIR)/$(MICROSERVICE_MEATS)

# Commands
CARBS_CMD := ./$(CMD_DIR)/$(MICROSERVICE_CARBS)
DAIRY_CMD := ./$(CMD_DIR)/$(MICROSERVICE_DAIRY)
VEGETABLES_CMD := ./$(CMD_DIR)/$(MICROSERVICE_VEGETABLES)
MEATS_CMD := ./$(CMD_DIR)/$(MICROSERVICE_MEATS)

# Default target
all: carbs dairy vegetables meats

# Build commands
carbs:
	go build -o $(CARBS_BIN) $(CARBS_CMD)

dairy:
	go build -o $(DAIRY_BIN) $(DAIRY_CMD)

vegetables:
	go build -o $(VEGETABLES_BIN) $(VEGETABLES_CMD)

meats:
	go build -o $(MEATS_BIN) $(MEATS_CMD)

# Clean up binaries
clean:
	rm -f $(BIN_DIR)/*
