# Go Cheat Sheet

# Index

## Credits

Most example code taken from [A Tour of Go](http://tour.golang.org/), which is an excellent introduction to Go.
If you're new to Go, do that tour. Seriously.

## Go in a Nutshell

- Imperative language
- Statically typed
- Syntax tokens similar to C (but less parentheses and no semicolons) and the structure to Oberon-2
- Compiles to native code (no JVM)
- No classes, but structs with methods
- Interfaces
- No implementation inheritance. There's [type embedding](http://golang.org/doc/effective%5Fgo.html#embedding), though.
- Functions are first class citizens
- Functions can return multiple values
- Has closures
- Pointers, but not pointer arithmetic
- Built-in concurrency primitives: Goroutines and Channels

# Basic Syntax

## Hello World

File `hello.go`:

```go
package main

import "fmt"

func main() {
    fmt.Println("Hello Go")
}
```

`$ go run hello.go`

## Operators

### Arithmetic

| Operator | Description         |
| -------- | ------------------- |
| `+`      | addition            |
| `-`      | subtraction         |
| `*`      | multiplication      |
| `/`      | quotient            |
| `%`      | remainder           |
| `&`      | bitwise and         |
| `\|`     | bitwise or          |
| `^`      | bitwise xor         |
| `&^`     | bit clear (and not) |
| `<<`     | left shift          |
| `>>`     | right shift         |

### Comparison

| Operator | Description           |
| -------- | --------------------- |
| `==`     | equal                 |
| `!=`     | not equal             |
| `<`      | less than             |
| `<=`     | less than or equal    |
| `>`      | greater than          |
| `>=`     | greater than or equal |

### Logical

| Operator | Description |
| -------- | ----------- |
| `&&`     | logical and |
| `\|\|`   | logical or  |
| `!`      | logical not |

### Other

| Operator | Description                                    |
| -------- | ---------------------------------------------- |
| `&`      | address of / create pointer                    |
| `*`      | dereference pointer                            |
| `<-`     | send / receive operator (see 'Channels' below) |

## Declarations

Type goes after identifier!

```go
var foo int // declaration without initialization
var foo int = 42 // declaration with initialization
var foo, bar int = 42, 1302 // declare and init multiple vars at once
var foo = 42 // type omitted, will be inferred
foo := 42 // shorthand, only in func bodies, omit var keyword, type is always implicit
const constant = "This is a constant"

// iota can be used for incrementing numbers, starting from 0
const (
    _ = iota
    a
    b
    c = 1 << iota
    d
)
    fmt.Println(a, b) // 1 2 (0 is skipped)
    fmt.Println(c, d) // 8 16 (2^3, 2^4)
```

## Functions

```go
// a simple function
func functionName() {}

// function with parameters (again, types go after identifiers)
func functionName(param1 string, param2 int) {}

// multiple parameters of the same type
func functionName(param1, param2 int) {}

// return type declaration
func functionName() int {
    return 42
}

// Can return multiple values at once
func returnMulti() (int, string) {
    return 42, "foobar"
}
var x, str = returnMulti()

// Return multiple named results simply by return
func returnMulti2() (n int, s string) {
    n = 42
    s = "foobar"
    // n and s will be returned
    return
}
var x, str = returnMulti2()

```

### Functions As Values And Closures

```go
func main() {
    // assign a function to a name
    add := func(a, b int) int {
        return a + b
    }
    // use the name to call the function
    fmt.Println(add(3, 4))
}

// Closures, lexically scoped: Functions can access values that were
// in scope when defining the function
func scope() func() int{
    outer_var := 2
    foo := func() int { return outer_var}
    return foo
}

func another_scope() func() int{
    // won't compile because outer_var and foo not defined in this scope
    outer_var = 444
    return foo
}


// Closures
func outer() (func() int, int) {
    outer_var := 2
    inner := func() int {
        outer_var += 99 // outer_var from outer scope is mutated.
        return outer_var
    }
    inner()
    return inner, outer_var // return inner func and mutated outer_var 101
}
```

### Variadic Functions

```go
func main() {
	fmt.Println(adder(1, 2, 3)) 	// 6
	fmt.Println(adder(9, 9))	// 18

	nums := []int{10, 20, 30}
	fmt.Println(adder(nums...))	// 60
}

// By using ... before the type name of the last parameter you can indicate that it takes zero or more of those parameters.
// The function is invoked like any other function except we can pass as many arguments as we want.
func adder(args ...int) int {
	total := 0
	for _, v := range args { // Iterates over the arguments whatever the number.
		total += v
	}
	return total
}
```

## Built-in Types

```go
bool

string

int  int8  int16  int32  int64
uint uint8 uint16 uint32 uint64 uintptr

byte // alias for uint8

rune // alias for int32 ~= a character (Unicode code point) - very Viking

float32 float64

complex64 complex128
```

All Go's predeclared identifiers are defined in the [builtin](https://golang.org/pkg/builtin/) package.

## Type Conversions

```go
var i int = 42
var f float64 = float64(i)
var u uint = uint(f)

// alternative syntax
i := 42
f := float64(i)
u := uint(f)
```

## Packages

- Package declaration at top of every source file
- Executables are in package `main`
- Convention: package name == last name of import path (import path `math/rand` => package `rand`)
- Upper case identifier: exported (visible from other packages)
- Lower case identifier: private (not visible from other packages)

## Control structures

### If

```go
func main() {
	// Basic one
	if x > 10 {
		return x
	} else if x == 10 {
		return 10
	} else {
		return -x
	}

	// You can put one statement before the condition
	if a := b + c; a < 42 {
		return a
	} else {
		return a - 42
	}

	// Type assertion inside if
	var val interface{} = "foo"
	if str, ok := val.(string); ok {
		fmt.Println(str)
	}
}
```

### Loops

```go
    // There's only `for`, no `while`, no `until`
    for i := 1; i < 10; i++ {
    }
    for ; i < 10;  { // while - loop
    }
    for i < 10  { // you can omit semicolons if there is only a condition
    }
    for { // you can omit the condition ~ while (true)
    }

    // use break/continue on current loop
    // use break/continue with label on outer loop
here:
    for i := 0; i < 2; i++ {
        for j := i + 1; j < 3; j++ {
            if i == 0 {
                continue here
            }
            fmt.Println(j)
            if j == 2 {
                break
            }
        }
    }

there:
    for i := 0; i < 2; i++ {
        for j := i + 1; j < 3; j++ {
            if j == 1 {
                continue
            }
            fmt.Println(j)
            if j == 2 {
                break there
            }
        }
    }
```

### Switch

```go
    // switch statement
    switch operatingSystem {
    case "darwin":
        fmt.Println("Mac OS Hipster")
        // cases break automatically, no fallthrough by default
    case "linux":
        fmt.Println("Linux Geek")
    default:
        // Windows, BSD, ...
        fmt.Println("Other")
    }

    // as with for and if, you can have an assignment statement before the switch value
    switch os := runtime.GOOS; os {
    case "darwin": ...
    }

    // you can also make comparisons in switch cases
    number := 42
    switch {
        case number < 42:
            fmt.Println("Smaller")
        case number == 42:
            fmt.Println("Equal")
        case number > 42:
            fmt.Println("Greater")
    }

    // cases can be presented in comma-separated lists
    var char byte = '?'
    switch char {
        case ' ', '?', '&', '=', '#', '+', '%':
            fmt.Println("Should escape")
    }
```

## Arrays, Slices, Ranges

### Arrays

```go
var a [10]int // declare an int array with length 10. Array length is part of the type!
a[3] = 42     // set elements
i := a[3]     // read elements

// declare and initialize
var a = [2]int{1, 2}
a := [2]int{1, 2} //shorthand
a := [...]int{1, 2} // elipsis -> Compiler figures out array length
```

### Slices

```go
var a []int                              // declare a slice - similar to an array, but length is unspecified
var a = []int {1, 2, 3, 4}               // declare and initialize a slice (backed by the array given implicitly)
a := []int{1, 2, 3, 4}                   // shorthand
chars := []string{0:"a", 2:"c", 1: "b"}  // ["a", "b", "c"]

var b = a[lo:hi]	// creates a slice (view of the array) from index lo to hi-1
var b = a[1:4]		// slice from index 1 to 3
var b = a[:3]		// missing low index implies 0
var b = a[3:]		// missing high index implies len(a)
a =  append(a,17,3)	// append items to slice a
c := append(a,b...)	// concatenate slices a and b

// create a slice with make
a = make([]byte, 5, 5)	// first arg length, second capacity
a = make([]byte, 5)	// capacity is optional

// create a slice from an array
x := [3]string{"Лайка", "Белка", "Стрелка"}
s := x[:] // a slice referencing the storage of x
```

### Operations on Arrays and Slices

`len(a)` gives you the length of an array/a slice. It's a built-in function, not a attribute/method on the array.

```go
// loop over an array/a slice
for i, e := range a {
    // i is the index, e the element
}

// if you only need e:
for _, e := range a {
    // e is the element
}

// ...and if you only need the index
for i := range a {
}

// In Go pre-1.4, you'll get a compiler error if you're not using i and e.
// Go 1.4 introduced a variable-free form, so that you can do this
for range time.Tick(time.Second) {
    // do it once a sec
}

```

## Maps

```go
m := make(map[string]int)
m["key"] = 42
fmt.Println(m["key"])

delete(m, "key")

elem, ok := m["key"] // test if key "key" is present and retrieve it, if so

// map literal
var m = map[string]Vertex{
    "Bell Labs": {40.68433, -74.39967},
    "Google":    {37.42202, -122.08408},
}

// iterate over map content
for key, value := range m {
}

```

## Structs

There are no classes, only structs. Structs can have methods.

```go
// A struct is a type. It's also a collection of fields

// Declaration
type Vertex struct {
    X, Y float64
}

// Creating
var v = Vertex{1, 2}
var v = Vertex{X: 1, Y: 2} // Creates a struct by defining values with keys
var v = []Vertex{{1,2},{5,2},{5,5}} // Initialize a slice of structs

// Accessing members
v.X = 4

// You can declare methods on structs. The struct you want to declare the
// method on (the receiving type) comes between the the func keyword and
// the method name. The struct is copied on each method call(!)
func (v Vertex) Abs() float64 {
    return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

// Call method
v.Abs()

// For mutating methods, you need to use a pointer (see below) to the Struct
// as the type. With this, the struct value is not copied for the method call.
func (v *Vertex) add(n float64) {
    v.X += n
    v.Y += n
}

```

**Anonymous structs:**
Cheaper and safer than using `map[string]interface{}`.

```go
point := struct {
	X, Y int
}{1, 2}
```

## Pointers

```go
p := Vertex{1, 2}  // p is a Vertex
q := &p            // q is a pointer to a Vertex
r := &Vertex{1, 2} // r is also a pointer to a Vertex

// The type of a pointer to a Vertex is *Vertex

var s *Vertex = new(Vertex) // new creates a pointer to a new struct instance
```

## Interfaces

```go
// interface declaration
type Awesomizer interface {
    Awesomize() string
}

// types do *not* declare to implement interfaces
type Foo struct {}

// instead, types implicitly satisfy an interface if they implement all required methods
func (foo Foo) Awesomize() string {
    return "Awesome!"
}
```

## Embedding

There is no subclassing in Go. Instead, there is interface and struct embedding.

```go
// ReadWriter implementations must satisfy both Reader and Writer
type ReadWriter interface {
    Reader
    Writer
}

// Server exposes all the methods that Logger has
type Server struct {
    Host string
    Port int
    *log.Logger
}

// initialize the embedded type the usual way
server := &Server{"localhost", 80, log.New(...)}

// methods implemented on the embedded struct are passed through
server.Log(...) // calls server.Logger.Log(...)

// the field name of the embedded type is its type name (in this case Logger)
var logger *log.Logger = server.Logger
```

## Errors

There is no exception handling. Instead, functions that might produce an error just declare an additional return value of type [`error`](https://golang.org/pkg/builtin/#error). This is the `error` interface:

```go
// The error built-in interface type is the conventional interface for representing an error condition,
// with the nil value representing no error.
type error interface {
    Error() string
}
```

Here's an example:

```go
func sqrt(x float64) (float64, error) {
	if x < 0 {
		return 0, errors.New("negative value")
	}
	return math.Sqrt(x), nil
}

func main() {
	val, err := sqrt(-1)
	if err != nil {
		// handle error
		fmt.Println(err) // negative value
		return
	}
	// All is good, use `val`.
	fmt.Println(val)
}
```

# Concurrency

## Goroutines

Goroutines are lightweight threads (managed by Go, not OS threads). `go f(a, b)` starts a new goroutine which runs `f` (given `f` is a function).

```go
// just a function (which can be later started as a goroutine)
func doStuff(s string) {
}

func main() {
    // using a named function in a goroutine
    go doStuff("foobar")

    // using an anonymous inner function in a goroutine
    go func (x int) {
        // function body goes here
    }(42)
}
```

## Channels

```go
ch := make(chan int) // create a channel of type int
ch <- 42             // Send a value to the channel ch.
v := <-ch            // Receive a value from ch

// Non-buffered channels block. Read blocks when no value is available, write blocks until there is a read.

// Create a buffered channel. Writing to a buffered channels does not block if less than <buffer size> unread values have been written.
ch := make(chan int, 100)

close(ch) // closes the channel (only sender should close)

// read from channel and test if it has been closed
v, ok := <-ch

// if ok is false, channel has been closed

// Read from channel until it is closed
for i := range ch {
    fmt.Println(i)
}

// select blocks on multiple channel operations, if one unblocks, the corresponding case is executed
func doStuff(channelOut, channelIn chan int) {
    select {
    case channelOut <- 42:
        fmt.Println("We could write to channelOut!")
    case x := <- channelIn:
        fmt.Println("We could read from channelIn")
    case <-time.After(time.Second * 1):
        fmt.Println("timeout")
    }
}
```

### Channel Axioms

- A send to a nil channel blocks forever

  ```go
  var c chan string
  c <- "Hello, World!"
  // fatal error: all goroutines are asleep - deadlock!
  ```

- A receive from a nil channel blocks forever

  ```go
  var c chan string
  fmt.Println(<-c)
  // fatal error: all goroutines are asleep - deadlock!
  ```

- A send to a closed channel panics

  ```go
  var c = make(chan string, 1)
  c <- "Hello, World!"
  close(c)
  c <- "Hello, Panic!"
  // panic: send on closed channel
  ```

- A receive from a closed channel returns the zero value immediately

  ```go
  var c = make(chan int, 2)
  c <- 1
  c <- 2
  close(c)
  for i := 0; i < 3; i++ {
      fmt.Printf("%d ", <-c)
  }
  // 1 2 0
  ```

## Printing

```go
fmt.Println("Hello, 你好, नमस्ते, Привет, ᎣᏏᏲ") // basic print, plus newline
p := struct { X, Y int }{ 17, 2 }
fmt.Println( "My point:", p, "x coord=", p.X ) // print structs, ints, etc
s := fmt.Sprintln( "My point:", p, "x coord=", p.X ) // print to string variable

fmt.Printf("%d hex:%x bin:%b fp:%f sci:%e",17,17,17,17.0,17.0) // c-ish format
s2 := fmt.Sprintf( "%d %f", 17, 17.0 ) // formatted print to string variable

hellomsg := `
 "Hello" in Chinese is 你好 ('Ni Hao')
 "Hello" in Hindi is नमस्ते ('Namaste')
` // multi-line string literal, using back-tick at beginning and end
```

## Reflection

### Type Switch

A type switch is like a regular switch statement, but the cases in a type switch specify types (not values) which are compared against the type of the value held by the given interface value.

```go
func do(i interface{}) {
	switch v := i.(type) {
	case int:
		fmt.Printf("Twice %v is %v\n", v, v*2)
	case string:
		fmt.Printf("%q is %v bytes long\n", v, len(v))
	default:
		fmt.Printf("I don't know about type %T!\n", v)
	}
}

func main() {
	do(21)
	do("hello")
	do(true)
}
```

# Snippets

## Files Embedding

Go programs can embed static files using the `"embed"` package as follows:

```go
package main

import (
	"embed"
	"log"
	"net/http"
)

// content holds the static content (2 files) for the web server.
//go:embed a.txt b.txt
var content embed.FS

func main() {
	http.Handle("/", http.FileServer(http.FS(content)))
	log.Fatal(http.ListenAndServe(":8080", nil))
}
```

[Full Playground Example](https://play.golang.org/p/pwWxdrQSrYv)

## HTTP Server

```go
package main

import (
    "fmt"
    "net/http"
)

// define a type for the response
type Hello struct{}

// let that type implement the ServeHTTP method (defined in interface http.Handler)
func (h Hello) ServeHTTP(w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "Hello!")
}

func main() {
    var h Hello
    http.ListenAndServe("localhost:4000", h)
}

// Here's the method signature of http.ServeHTTP:
// type Handler interface {
//     ServeHTTP(w http.ResponseWriter, r *http.Request)
// }
```

# Beyond Tour of Go

## Go Concurrency

### Goroutines {.row-span-2}

```go
package main

import (
	"fmt"
	"time"
)

func f(from string) {
	for i := 0; i < 3; i++ {
		fmt.Println(from, ":", i)
	}
}

func main() {
	f("direct")
	go f("goroutine")

	go func(msg string) {
		fmt.Println(msg)
	}("going")

	time.Sleep(time.Second)
	fmt.Println("done")
}
```

See: [Goroutines](https://tour.go.dev/concurrency/1), [Channels](https://tour.go.dev/concurrency/2)

### WaitGroup {.row-span-2}

```go
package main

import (
	"fmt"
	"sync"
	"time"
)

func w(id int, wg *sync.WaitGroup) {
	defer wg.Done()
	fmt.Printf("%d starting\n", id)

	time.Sleep(time.Second)
	fmt.Printf("%d done\n", id)
}

func main() {
	var wg sync.WaitGroup
	for i := 1; i <= 5; i++ {
		wg.Add(1)
		go w(i, &wg)
	}
	wg.Wait()
}
```

See: [WaitGroup](https://go.dev/pkg/sync/#WaitGroup)

### Closing channels

```go
ch <- 1
ch <- 2
ch <- 3
close(ch) // Closes a channel
```

---

```go
// Iterate the channel until closed
for i := range ch {
  ···
}
```

---

```go
// Closed if `ok == false`
v, ok := <- ch
```

See: [Range and close](https://tour.go.dev/concurrency/4)

### Buffered channels

```go
ch := make(chan int, 2)
ch <- 1
ch <- 2
ch <- 3
// fatal error:
// all goroutines are asleep - deadlock
```

See: [Buffered channels](https://tour.go.dev/concurrency/3)

## Go Error control

### Deferring functions

```go
func main() {
  defer func() {
    fmt.Println("Done")
  }()
  fmt.Println("Working...")
}
```

### Lambda defer

```go
func main() {
  var d = int64(0)
  defer func(d *int64) {
    fmt.Printf("& %v Unix Sec\n", *d)
  }(&d)
  fmt.Print("Done ")
  d = time.Now().Unix()
}
```

The defer func uses current value of d, unless we use a pointer to get final value at end of main.

### Defer

```go
func main() {
  defer fmt.Println("Done")
  fmt.Println("Working...")
}
```

See: [Defer, panic and recover](https://blog.go.dev/defer-panic-and-recover)

## Go Methods {.cols-2}

### Receivers

```go
type Vertex struct {
  X, Y float64
}
```

```go
func (v Vertex) Abs() float64 {
  return math.Sqrt(v.X * v.X + v.Y * v.Y)
}
```

```go
v := Vertex{1, 2}
v.Abs()
```

See: [Methods](https://tour.go.dev/methods/1)

### Mutation

```go
func (v *Vertex) Scale(f float64) {
  v.X = v.X * f
  v.Y = v.Y * f
}
```

```go
v := Vertex{6, 12}
v.Scale(0.5)
// `v` is updated
```

See: [Pointer receivers](https://tour.go.dev/methods/4)

## Go Interfaces {.cols-2}

### A basic interface

```go
type Shape interface {
  Area() float64
  Perimeter() float64
}
```

### Struct

```go
type Rectangle struct {
  Length, Width float64
}
```

Struct `Rectangle` implicitly implements interface `Shape` by implementing all of its methods.

### Methods

```go
func (r Rectangle) Area() float64 {
  return r.Length * r.Width
}

func (r Rectangle) Perimeter() float64 {
  return 2 * (r.Length + r.Width)
}
```

The methods defined in `Shape` are implemented in `Rectangle`.

### Interface example

```go {.wrap}
func main() {
  var r Shape = Rectangle{Length: 3, Width: 4}
  fmt.Printf("Type of r: %T, Area: %v, Perimeter: %v.", r, r.Area(), r.Perimeter())
}

```

## Go generics {.cols-2}

### example 1

```go
// comparable represents types that can be compared.
type comparable interface {
	int | float64 | string
}

// Max returns the maximum of two comparable values.
func Max[T comparable](a, b T) T {
	if a > b {
		return a
	}
	return b
}

func main() {
	// Find the maximum of two integers.
	maxInt := Max(10, 20)
	fmt.Println("Max integer:", maxInt)

	// Find the maximum of two floats.
	maxFloat := Max(3.14, 2.71)
	fmt.Println("Max float:", maxFloat)

	// Find the maximum of two strings.
	maxString := Max("apple", "banana")
	fmt.Println("Max string:", maxString)
}

```

### example 2

```go

// Pair[T, U] represents a generic pair of values.
type Pair[T, U any] struct {
	First  T
	Second U
}

func main() {
	pair := Pair[int, string]{First: 42, Second: "hello"}

	fmt.Println("First:", pair.First)
	fmt.Println("Second:", pair.Second)

	// Print the types of the values in the pair.
	fmt.Println("Type of First:", reflect.TypeOf(pair.First))
	fmt.Println("Type of Second:", reflect.TypeOf(pair.Second))
}

```

## Go File I/O {.cols-2}

### Reading a File

Read the contents of a file into memory.

```go
data, err := os.ReadFile("file.txt")
if err != nil {
    log.Fatal(err)
}
```

### Writing to a File

Write data to a file with specific permissions (e.g., 0644 for read-write).

```go
err := os.WriteFile("file.txt", []byte("Hello, Go!"), 0644)
```

## Go Testing {.cols-2}

### Unit Test

Unit Test: A basic unit test follows the below naming convention and uses t.Errorf() to report failures.

```go
func TestAdd(t *testing.T) {
    result := add(2, 3)
    if result != 5 {
        t.Errorf("Expected 5, got %d", result)
    }
}
```

### Unit Test

Benchmark: Benchmark tests measure performance, using b.N to control iterations.

```go
func BenchmarkAdd(b *testing.B) {
    for i := 0; i < b.N; i++ {
        add(1, 2)
    }
}
```

## Go JSON Handling {.cols-2}

### JSON Encoding

Convert a Go struct to JSON.

```go
data, _ := json.Marshal(person)
```

### JSON Decoding

Parse JSON data into a Go struct.

```go
json.Unmarshal(data, &person)
```

## Go Server {.cols-2}

### net/http (Standard Library)

```go
package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprint(w, "Hello from net/http!")
}

func main() {

    http.HandleFunc("/", handler)

    http.ListenAndServe(":8080", nil)
}

```

### gorilla/mux

```go
package main

import (
    "fmt"
    "net/http"
    "github.com/gorilla/mux"
)

func main() {

    r := mux.NewRouter()

    r.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprint(w, "Hello from Gorilla Mux!")
    })

    http.ListenAndServe(":8081", r)
}

```

### chi

```go
package main

import (
    "fmt"
    "net/http"
    "github.com/go-chi/chi/v5"
)

func main() {

    r := chi.NewRouter()

    r.Get("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprint(w, "Hello from Chi!")
    })

    http.ListenAndServe(":8082", r)
}
```

### gin

```go
package main

import (
    "github.com/gin-gonic/gin"
)

func main() {

    r := gin.Default()

    r.GET("/", func(c *gin.Context) {
        c.String(200, "Hello from Gin!")
    })

    r.Run(":8083")
}
```

### fiber

```go
package main

import (
    "github.com/gofiber/fiber/v3"
)

func main() {

    app := fiber.New()

    app.Get("/", func(c *fiber.Ctx) error {
        return c.SendString("Hello from Fiber!")
    })

    app.Listen(":8084")
}
```

### beego

```go
package main

import (
    "github.com/beego/beego/v2/server/web"
)

func main() {

    web.Get("/", func(ctx *web.Context) {
        ctx.Output.Body([]byte("Hello from Beego!"))
    })

    web.Run()
}

```

## Miscellaneous

### Keywords

- `break`
- `default`
- `func`
- `interface`
- `select`
- `case`
- `defer`
- `go`
- `map`
- `struct`
- `chan`
- `else`
- `goto`
- `package`
- `switch`
- `const`
- `fallthrough`
- `if`
- `range`
- `type`
- `continue`
- `for`
- `import`
- `return`
- `var`
- `iota`

{.cols-3 .marker-none}

### Operators and punctuation

|                 |                 |                  |                  |                   |      |       |     |     |
| --------------- | --------------- | ---------------- | ---------------- | ----------------- | ---- | ----- | --- | --- |
| `+`             | `&`             | `+=`             | `&=`             | `&&`              | `==` | `!=`  | `(` | `)` |
| `-`             | <code>\|</code> | `-=`             | <code>\|=</code> | <code>\|\|</code> | `<`  | `<=`  | `[` | `]` |
| <code>\*</code> | `^`             | <code>\*=</code> | `^=`             | `<-`              | `>`  | `>=`  | `{` | `}` |
| `/`             | `<<`            | `/=`             | `<<=`            | `++`              | `=`  | `:=`  | `,` | `;` |
| `%`             | `>>`            | `%=`             | `>>=`            | `--`              | `!`  | `...` | `.` | `:` |
|                 | `&^`            | `&^=`            |                  |                   |      |       |     |     |

## Also see {.cols-1}

- [Devhints](https://devhints.io/go) _(devhints.io)_
- [A tour of Go](https://tour.go.dev/welcome/1) _(tour.go.dev)_
- [Go wiki](https://github.com/golang/go/wiki/) _(github.com)_
- [Effective Go](https://go.dev/doc/effective_go) _(go.dev)_
- [Go by Example](https://gobyexample.com/) _(gobyexample.com)_
- [Awesome Go](https://awesome-go.com/) _(awesome-go.com)_
- [JustForFunc Youtube](https://www.youtube.com/channel/UC_BzFbxG2za3bp5NRRRXJSw) _(youtube.com)_
- [Style Guide](https://github.com/golang/go/wiki/CodeReviewComments) _(github.com)_
