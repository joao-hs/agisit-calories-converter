package app

import (
	"agisit24-g10/be/pkg/logger"
	"net/http"
	"strconv"
)

type Router interface {
	Route()
}

type router struct {
	app App
}

func NewRouter(app App) Router {
	return &router{app: app}
}

func (router *router) Route() {
	http.HandleFunc("/", router.computeCalories)
}

func (router *router) computeCalories(w http.ResponseWriter, r *http.Request) {
	// get header
	reqID := r.Header.Get("Request-Id")
	if reqID == "" {
		logger.Error("Request-Id header is required")
		http.Error(w, "Request-Id header is required", http.StatusBadRequest)
		return
	}

	foodID := r.URL.Path[1:] // after the "/"
	if foodID == "" {
		logger.Error("foodID unknown")
		http.Error(w, "foodID unknown", http.StatusBadRequest)
		return
	}

	r.ParseForm()
	weightStr := r.Form.Get("weight")
	if weightStr == "" {
		logger.Error("weight parameter is required")
		http.Error(w, "weight parameter is required", http.StatusBadRequest)
		return
	}

	weight, err := strconv.Atoi(weightStr)
	if err != nil {
		http.Error(w, "weight must be an integer", http.StatusBadRequest)
		return
	}

	calories := router.app.ComputeCalories(foodID, weight)

	w.WriteHeader(http.StatusOK)
	w.Write([]byte(strconv.Itoa(calories)))
	logger.Infof("Request-Id: %s, Microservice: %s, Food: %s, Weight: %d, Calories: %d", reqID, router.app.Category(), foodID, weight, calories)
}
