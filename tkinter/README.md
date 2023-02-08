# tkinter

Author: MonoEven

## Installation

You should place all in folder in "thread" & all in folder "tkinter" under your lib folder.

Requires Autohotkey v2.0 or above.

## Quick start

!!! ArrayList, Boolean, HashMap, Toml...All these types which contains data, have a method named "toahk".

```autohotkey
filename := "test"
_file := fileopen(filename, "r")
_string := "a = 1"

_toml1 := Toml().read(_string)
_toml2 := Toml().read(_file)
_toml3 := Toml().read(_toml1)
_toml4 := Toml().read(filename, _type := "file")
_toml5 := Toml().read(filename, _type := "file", encoding := "utf-8")

_toml_with_defaults := Toml(_toml1).read(_file)
```

```autohotkey
_toml :=  Toml().read("a = 1")
filename := "test"
_file := fileopen(filename, "rw")
_writer := StringWriter()

; output will always be string.
output1 := TomlWriter().write(_toml)
output2 := TomlWriter().write(_toml, _writer)
; output2 == _writer.toString()
output3 := TomlWriter().write(_toml, _file)
; output3 == _file.read()
output4 := TomlWriter().write(_toml, filename)
; output4 == fileread(filename, "utf-8")
```

## Usage

A `com.moandjiezana.toml.Toml` instance is populated by calling one of `read(File)`, `read(Reader)`, `read(String)` or `read(Toml)`.

```autohotkey
_toml := Toml().read("a=1")
```

An exception is thrown if the source is not valid TOML.

The data can then be accessed either by converting the Toml instance to your own class or by accessing tables and keys by name.

### Maps

`Toml#toMap()` is a quick way to turn a Toml instance into a `Map<String, Object>`.

```autohotkey
_map := Toml().read("a=1").toMap()
```

### Custom classes

`Toml#to(Class)` change a Toml instance to the given class. If toml has a default value, it will behave differently from toml4j. It will first register the default value and then the current value. If the default value and the current value have a certain attribute, they will be spliced into an array.

```toml
name = "Mwanji Ezana"

[address]
  street = "123 A Street"
  city = "AnyVille"
  
[contacts]
  "email address" = "me@example.com"
```

```autohotkey
class User
{
  
}
```

```autohotkey
; must set protoFlag to false if you want to register subClass.
_user := new Toml().read(tomlFile).to(User, , protoFlag := false)

class User
{
    class address
    {
        static street := "123 A Street"
        static city := "AnyVille"
    }
    
    class contacts
    {
        ; autohotkey cannot direct set, but the effect is equal like this.
        static "email address" := "me@example.com"
    }
}
```

Any keys not found in both the TOML and the class are ignored. Fields may be private.

TOML primitives can be mapped to a number of Autohotkey types:

TOML | Autohotkey
---- | ----
Integer | `int`
Float | `float`
String | `string`
Multiline and Literal Strings | `string`
Array | `array`
Table | subClass

Custom classes, Maps and collections thereof can be nested to any level. See [TomlToClassTest#should_convert_fruit_table_array()](toml/test/TomlToClassTest.ahk) for an example.

### Key names

Use the getters to retrieve the data:

* `getString(String)`
* `getDate(String)`
* `getBoolean(String)`
* `getInt(String)`
* `getLong(String)`
* `getFloat(String)`
* `getDouble(String)`
* `getList(String)`
* `getTable(String)` returns a new Toml instance containing only the keys in that table.
* `getTables(String)`, for table arrays, returns `ArrayList<Toml>`. 

You can also navigate values within a table with a compound key of the form `table.key`. Use a zero-based index such as `tableArray[0].key` to navigate table arrays.

Non-existent keys return null.

When retrieving quoted keys, the quotes must be used and the key must be spelled exactly the same way, including quotes and whitespace. The only exceptions are Unicode escapes: `"\u00B1" = "value"` would be retrieved with `toml.getString("\"±\"")`.

```toml
title = "TOML Example"
"sub title" = "Now with quoted keys"

[database]
  ports = [ 8001, 8001, 8002 ]
  enabled = true
  [database.credentials]
    password = "password"
    
[servers]
  cluster = "hyades"
  [servers.alpha]
  ip = "10.0.0.1"
  
[[networks]]
  name = "Level 1"
  [networks.status]
    bandwidth = 10

[[networks]]
  name = "Level 2"

[[networks]]
  name = "Level 3"
  [[networks.operators]]
    location = "Geneva"
  [[networks.operators]]
    location = "Paris"
```

```autohotkey
_toml := Toml().read(tomlFile)

title := _toml.getString("title")
subTitle := _toml.getString("`"sub title`"")
enabled := _toml.getBoolean("database.enabled")
ports := _toml.getList("database.ports")
password := _toml.getString("database.credentials.password")

servers := _toml.getTable("servers")
cluster := servers.getString("cluster") ; navigation is relative to current Toml instance
ip := servers.getString("alpha.ip")

network1 := _toml.getTable("networks[0]")
network2Name := _toml.getString("networks[1].name") ;  "Level 2"
network3Operators := _toml.getTables("networks[2].operators")
network3Operator2Location := _toml.getString("networks[2].operators[1].location") ; "Paris"
```

### Defaults

The constructor can be given a set of default values that will be used as fallbacks. For tables and table arrays, a shallow merge is performed.

`Toml#read(Toml)` is used to merge two Toml instances:

```autohotkey
toml1 := Toml().read("a=1")
toml2 := Toml().read(tomlFile)

mergedToml := Toml(toml1).read(toml2)
```

You can also call an overloaded version of the getters that take a default value. Note that the default value provided in the constructor take precedence over the one provided by the getter.

```toml
# defaults
a = 2
b = 3

[table]
  c = 4
  d = 5
```

```toml
a = 1

[table]
  c = 2
  
[[array]]
  d = 3
```

```autohotkey
defaults := Toml().read(tomlDefaultsFile
_toml := Toml(defaults).read(tomlFile)

a := _toml.getLong("a") ; returns 1, not 2
b := _toml.getLong("b") ; returns 3, taken from defaults provided to constructor
bPrefersConstructor := _toml.getLong("b", 5) ; returns 3, not 5
c := _toml.getLong("c") ; returns Java.Null()
cWithDefault := _toml.getLong("c", 5) ; returns 5
tableC := _toml.getLong("table.c") ; returns 2, not 4
tableD := _toml.getLong("table.d") ; returns Java.Null(), not 5, because of shallow merge
arrayD := _toml.getLong("array[0].d") ; returns 3
```

### Reflection

`Toml#entrySet()` returns a enum of [Map.Entry](http://docs.oracle.com/javase/6/docs/api/java/util/Map.Entry.html) instances. Modifications to the returned Set are not reflected in the Toml instance.

```autohotkey
for entry in myToml.entrySet()
{
    msgbox(entry.getKey() . " " . entry.getValue())
}
```

`Toml#contains(String)` verifies that the instance contains a key of any type (primitive, table or array of tables) of the given  name. `Toml#containsPrimitive(String)`, `Toml#containsTable(String)` and `Toml#containsTableArray(String)` return true only if a key exists and is a primitive, table or array of tables, respectively. Compound keys can be used to check existence at any depth.


```autohotkey
_toml := Toml().read("a = 1")

_toml.contains("a") ; true
_toml.conatinsKey("a") ; true
_toml.containsTable("a") ; false
_toml.containsTableArray("a") ; false
```

### Converting Objects To TOML

You can write `Map`s, custom Objects and Class to a TOML `String` or `File` with a `TomlWriter`. Each TomlWriter instance is customisable, immutable and threadsafe, so it can be reused and passed around. Constants and transient fields are ignored.

To write a `Array` of objects as a table array, put the list in a `Map` or in a custom object.

```autohotkey
class AClass
{
  anInt := 1
  anArray := [ 2, 3 ]
}

_tomlWriter := TomlWriter()
obj := AClass()

_map := HashMap()
intArray := [ 2, 3 ]
_map.put("anInt", 1)
_map.put("anArray", intArray)

tomlString := _tomlWriter.write(obj)
tomlString := _tomlWriter.write(_map)

_tomlWriter.write(obj, "path/to/file")

/*
All methods output:
anInt = 1
anArray = [2, 3]
*/
```

You can customise formatting with a TomlWriter.Builder:

 ```autohotkey
obj := {aMap: {item: 1, a: {anInt: 1, anArray: [2, 3]} } }

_tomlWriter := TomlWriter.Builder()
  .indentValuesBy(2)
  .indentTablesBy(4)
  .padArrayDelimitersBy(3)
  .build()
    
tomlString := _tomlWriter.write(obj)

/*
Output:

[aMap]
  item = 1
  
    [aMap.a]
      anInt = 1
      anArray = [   2, 3   ]
*/
```
### Test

All tests are in the folder "toml\test".

### Limitations

Float value may not precisely.

Date type is can only toString.
