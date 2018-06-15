import { createStore } from "redux"

const persistedState = localStorage.getItem("reduxState") ? JSON.parse(localStorage.getItem("reduxState")) : "";

let store = createStore(authFn, persistedState);
store.subscribe(()=>{
  localStorage.setItem("reduxState", JSON.stringify(store.getState()));
})
export const authStore = store;

