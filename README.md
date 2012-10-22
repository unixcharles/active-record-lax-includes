ActiveRecord-lax-includes
=========================

By default ActiveRecord will raise an error when trying to eager load association that doesn't exist.

This can be an issue with polymorphism or STI.

See this issue for more details: https://github.com/rails/rails/issues/8005

Usage
-----

```
ActiveRecord::lax_includes do
  # ... record with missing association are filtered out instead of raising an error
end

# back to normal `Association named '****' was not found; perhaps you misspelled it?` exception.
```