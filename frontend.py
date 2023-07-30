import streamlit as st
from container_test.something import this_works

st.title("Streamlit Test")

st.write(this_works())

st.balloons()
