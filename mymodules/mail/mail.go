package mail

import (
	"time"

	progressbar "github.com/mconintet/progressbar"
	"github.com/yuin/gopher-lua"
)

func Preload(L *lua.LState) {
	L.PreloadModule("mail", Loader)
}

func Loader(L *lua.LState) int {
	// register functions to the table
	mod := L.SetFuncs(L.NewTable(), exports)
	// register other stuff
	// L.SetField(mod, "name", lua.LString("value"))

	// returns the module
	L.Push(mod)
	return 1
}

var exports = map[string]lua.LGFunction{
	"send": Send,
}

func Send(L *lua.LState) int {
	str := L.CheckString(1)
	println("开始发送邮件...")
	println("内容: " + str)
	for i := 1; i <= 100; i++ {
		time.Sleep(time.Millisecond * 10)
		progressbar.Show(float32(i) / 100.00)
	}
	// if err != nil {
	// 	L.Push(lua.LNil)
	// 	L.Push(lua.LString(err.Error()))
	// 	return 2
	// }
	return 0
}
