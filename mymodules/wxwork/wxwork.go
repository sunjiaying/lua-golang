package wxwork

import (
	"time"

	progressbar "github.com/mconintet/progressbar"
	"github.com/yuin/gopher-lua"
)

func Preload(L *lua.LState) {
	L.PreloadModule("wxwork", Loader)
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
	println("开始发送企业微信通知...")
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
