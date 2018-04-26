import { authStore } from "../stores/authStore.jsx";

const isLogged = () => {
  if(authStore.getState().jwt !== "")
    return true;
  return false;
}

const logOut = () => {
  if(authStore.getState().jwt !== "")
    authStore.dispatch({type: "", jwt: ""});
}

export {isLogged, logOut};
