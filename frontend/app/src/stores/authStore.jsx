import { createStore } from "redux"

const persistedState = localStorage.getItem("reduxState") ? JSON.parse(localStorage.getItem("reduxState")) : "";

let authFn = (state=persistedState, action) => {
  if(action.jwt === undefined)
    return state;
  else
    return Object.assign({}, {jwt: action.jwt});
}


let store = createStore(authFn, persistedState);
store.subscribe(()=>{
  localStorage.setItem("reduxState", JSON.stringify(store.getState()));
})
export const authStore = store;

