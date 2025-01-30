#!/bin/bash

apt update -y
apt install -y unzip

    wget https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/menu/ULTRASONIC_BASH
    unzip ULTRASONIC_BASH
    chmod +x menu/*
    mv menu/* /usr/local/sbin
    rm -rf menu
    rm -rf ULTRASONIC_BASH
    
    wget https://raw.githubusercontent.com/CODE1-cpu/xscriptx/main/menu/ULTRASONIC_PYTHON
    unzip ULTRASONIC_PYTHON
    chmod +x menu/*
    mv menu/* /usr/bin
    rm -rf menu
    rm -rf ULTRASONIC_PYTHON    
