package storage

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strconv"
	"strings"
)

type StorageDevice interface {
	GetCaloriesPer100g(string) (int, error)
	GetAvgCaloriesPer100gOfCategory(string) (int, error)
	PostLog(string, string) error
}

type storage struct {
}

var storageDeviceUrl string

func init() {
	storageDeviceUrl = os.Getenv("STORAGE_DEVICE_URL")
}

func NewStorage() StorageDevice {
	return &storage{}
}

func (*storage) GetCaloriesPer100g(food string) (int, error) {
	resp, err := http.Get(storageDeviceUrl + "/food/" + food)
	if err != nil {
		return 0, err
	}
	defer resp.Body.Close()

	var result map[string]interface{}
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return 0, err
	}

	caloriesStr, ok := result["calories_per_100g"].(string)
	if !ok {
		return 0, fmt.Errorf("unexpected response format")
	}

	calories, err := strconv.Atoi(caloriesStr)
	if err != nil {
		return 0, err
	}

	return calories, nil
}

func (*storage) GetAvgCaloriesPer100gOfCategory(category string) (int, error) {
	resp, err := http.Get(storageDeviceUrl + "/category/" + category)
	if err != nil {
		return 0, err
	}
	defer resp.Body.Close()

	var result map[string]interface{}
	if err := json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return 0, err
	}

	caloriesStr, ok := result["average_calories"].(string)
	if !ok {
		return 0, fmt.Errorf("unexpected response format")
	}

	calories, err := strconv.Atoi(caloriesStr)
	if err != nil {
		return 0, err
	}

	return calories, nil
}

func (*storage) PostLog(level string, log string) error {
	jsonPrintable := map[string]string{
		"level": level,
		"log":   log,
	}

	jsonData, err := json.Marshal(jsonPrintable)
	if err != nil {
		return err
	}

	resp, err := http.Post(storageDeviceUrl+"/log", "application/json", strings.NewReader(string(jsonData)))
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	return nil
}
