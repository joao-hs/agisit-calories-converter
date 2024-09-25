package logger

import (
	"agisit24-g10/be/pkg/storage"
	"fmt"

	log "github.com/sirupsen/logrus"
)

func init() {
	log.SetFormatter(&log.JSONFormatter{
		DisableTimestamp: true,
		PrettyPrint:      false,
	})
	log.SetLevel(log.InfoLevel)
}

func SetPrefix(prefix string, args ...string) {
	log.SetFormatter(&log.JSONFormatter{
		DisableTimestamp: true,
		PrettyPrint:      false,
		DataKey:          fmt.Sprintf(prefix, args),
	})
}

func Info(args ...interface{}) {
	printable := fmt.Sprint(args...)
	_ = storage.NewStorage().PostLog("info", printable)
	log.Info(printable)
}

func Infof(format string, args ...interface{}) {
	printable := fmt.Sprintf(format, args...)
	_ = storage.NewStorage().PostLog("info", printable)
	log.Info(printable)
}

func Error(args ...interface{}) {
	printable := fmt.Sprint(args...)
	_ = storage.NewStorage().PostLog("error", printable)
	log.Error(printable)
}

func Errorf(format string, args ...interface{}) {
	printable := fmt.Sprintf(format, args...)
	_ = storage.NewStorage().PostLog("error", printable)
	log.Error(format, printable)
}

func Fatal(args ...interface{}) {
	printable := fmt.Sprint(args...)
	_ = storage.NewStorage().PostLog("fatal", printable)
	log.Fatal(printable)
}

func Fatalf(format string, args ...interface{}) {
	printable := fmt.Sprintf(format, args...)
	_ = storage.NewStorage().PostLog("fatal", printable)
	log.Fatal(printable)
}
