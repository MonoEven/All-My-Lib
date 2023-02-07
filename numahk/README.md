# Numahk---A-Trial-For-Numpy-Autohotkey
> A Trial For Numpy &amp; Autohotkey-->[Source Code](https://github.com/MonoEven/Numahk---A-Trial-For-Numpy-Autohotkey/tree/main/Lib/numahk/dll)

You can easily use it like:
```Autohotkey
#Include <data\debug>
#Include <numahk\numahk>

a := numahk.array([1,2,3,4,5,6], numahk.float64).reshape(2,3)
debug a
debug numahk.mean(a, axis:=1)
; equal to
; debug a.mean(axis:=1)
```

> For ndarray, we can also use (ndarray).tolist() to make it to ahk-array.
> 
> More work may be done in the future.

```Autohotkey
numahk:(ndarray)
        add(ndarray)
        all(axis := "")
        any(axis := "")
        argmax(axis := "")
        argmin(axis := "")
        argpartition(kth, axis := -1)
        astype(dtype)
        choose(choices)
        clone()
        clip(ndarray_min, ndarray_max)
        compress(condition, axis := "")
        copy()
        cumprod(axis := "")
        cumsum(axis := "")
        diag(offset := 0)
        diagonal(offset := 0, axis1 := AHK_FLAG, axis2 := AHK_FLAG + 1)
        div(ndarray)
        dot(ndarray)
        dump(filename)
        fill(value)
        flatten()
        max(axis := "")
        mean(axis := "")
        min(axis := "")
        mul(ndarray)
        partition(kth, axis := -1)
        prod(axis := "")
        ptp(axis := "")
        put(index, value)
        ravel()
        reshape(shape*)
        resize(shape*)
        squeeze(axis := "")
        std(axis := "")
        sub(ndarray)
        sum(axis := "")
        swapaxes(axis1, axis2)
        transpose(axes := "")
        var(axis := "")
```

```Autohotkey
numahk.random:
        choice(ndarray, shape*)
        normal(loc := 0.0, scale := 1.0, shape*)
        rand(shape*)
        randint(start, end, shape*)
        randn(shape*)
        seed(seed)
```
