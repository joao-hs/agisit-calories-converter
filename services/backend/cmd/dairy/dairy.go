package main

import (
	"agisit24-g10/be/pkg/app"
	"agisit24-g10/be/pkg/logger"
	"agisit24-g10/be/pkg/storage"
	"net/http"
)

const categoryName = "dairy"

type dairyCategory struct {
	storage storage.StorageDevice
}

func (c *dairyCategory) Name() string {
	return categoryName
}

func (c *dairyCategory) FetchAvgCaloriesPer100g() int {
	val, err := c.storage.GetAvgCaloriesPer100gOfCategory(c.Name())
	if err != nil {
		logger.Error(err)
		return 0
	}

	return val
}

func main() {
	storageDevice := storage.NewStorage()

	category := &dairyCategory{
		storage: storageDevice,
	}

	application := app.NewApp(category, storageDevice)

	router := app.NewRouter(application)

	router.Route()
	logger.Fatal(http.ListenAndServe(":80", nil))
}
