import streamlit as st

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Title
st.title("🚖 OLA Ride Data Dashboard")

# Load data
@st.cache_data
def load_data():
    df = pd.read_csv("OLA_DataSet.csv")
    return df

df = load_data()

# Show dataset
st.subheader("📊 Raw Data")
st.write(df.head())

# Sidebar filters
st.sidebar.header("🔍 Filters")

# Example filters (adjust column names based on your dataset)
if "City" in df.columns:
    city = st.sidebar.selectbox("Select City", df["City"].unique())
    df = df[df["City"] == city]

if "Vehicle_Type" in df.columns:
    vehicle = st.sidebar.selectbox("Vehicle Type", df["Vehicle_Type"].unique())
    df = df[df["Vehicle_Type"] == vehicle]

# KPIs
st.subheader("📈 Key Metrics")

col1, col2, col3 = st.columns(3)

col1.metric("Total Rides", len(df))

if "Fare" in df.columns:
    col2.metric("Avg Fare", round(df["Fare"].mean(), 2))

if "Distance" in df.columns:
    col3.metric("Avg Distance", round(df["Distance"].mean(), 2))

# Chart 1: Ride count by category
st.subheader("🚗 Ride Distribution")

if "Vehicle_Type" in df.columns:
    fig, ax = plt.subplots()
    df["Vehicle_Type"].value_counts().plot(kind="bar", ax=ax)
    st.pyplot(fig)

# Chart 2: Fare Distribution
st.subheader("💰 Fare Distribution")

if "Fare" in df.columns:
    fig, ax = plt.subplots()
    sns.histplot(df["Fare"], kde=True, ax=ax)
    st.pyplot(fig)

# Chart 3: Rides over time
st.subheader("📅 Rides Over Time")

if "Date" in df.columns:
    df["Date"] = pd.to_datetime(df["Date"])
    rides_per_day = df.groupby(df["Date"].dt.date).size()

    fig, ax = plt.subplots()
    rides_per_day.plot(ax=ax)
    plt.xticks(rotation=45)
    st.pyplot(fig)

st.write(df.columns)