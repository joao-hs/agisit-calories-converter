package app

import (
	"agisit24-g10/be/pkg/storage"
	"math"
)

type Category interface {
	Name() string
	FetchAvgCaloriesPer100g() int
}

type App interface {
	GetAvgCaloriesPer100g() int
	ComputeCalories(string, int) int
	Category() string
}

type app struct {
	category                   Category
	storageDevice              storage.StorageDevice
	categoryAvgCaloriesPer100g int
}

func NewApp(category Category, storageDevice storage.StorageDevice) App {
	return &app{
		category:                   category,
		storageDevice:              storageDevice,
		categoryAvgCaloriesPer100g: 0,
	}
}

// GetAvgCaloriesPer100g for the category in a lazy manner
func (a *app) GetAvgCaloriesPer100g() int {
	if a.categoryAvgCaloriesPer100g == 0 {
		a.categoryAvgCaloriesPer100g = a.category.FetchAvgCaloriesPer100g()
	}
	return a.categoryAvgCaloriesPer100g

}

// ComputeCalories for a given food and weight, if food is unknown, use the category average calories per 100g
func (a *app) ComputeCalories(food string, weight int) int {
	caloriesPer100g, err := a.storageDevice.GetCaloriesPer100g(food)
	if err != nil {
		caloriesPer100g = a.GetAvgCaloriesPer100g()
	}

	return int(math.Round((float64(weight) / float64(100)) * float64(caloriesPer100g)))
}

func (a *app) Category() string {
	return a.category.Name()
}
