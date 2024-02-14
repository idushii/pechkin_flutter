#!/bin/bash

flutter build web  --base-href="/pechkin_flutter/"

cp -r build/web/* ./docs
