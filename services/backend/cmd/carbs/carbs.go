package main

import (
	"agisit24-g10/be/pkg/app"
	"agisit24-g10/be/pkg/logger"
	"agisit24-g10/be/pkg/storage"
	"net/http"
)

const categoryName = "carbs"

type carbsCategory struct {
	storage storage.StorageDevice
}

func (c *carbsCategory) Name() string {
	return categoryName
}

func (c *carbsCategory) FetchAvgCaloriesPer100g() int {
	val, err := c.storage.GetAvgCaloriesPer100gOfCategory(c.Name())
	if err != nil {
		logger.Error(err)
		return 0
	}

	return val
}

func main() {
	storageDevice := storage.NewStorage()

	category := &carbsCategory{
		storage: storageDevice,
	}

	application := app.NewApp(category, storageDevice)

	router := app.NewRouter(application)

	router.Route()
	logger.Fatal(http.ListenAndServe(":80", nil))
}
