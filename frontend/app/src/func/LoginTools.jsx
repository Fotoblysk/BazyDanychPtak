import { authStore } from "../stores/authStore.jsx";

const isLogged = () => {
  if(authStore.getState().jwt !== "")
    return true;
  return false;
}

const getRights = () => { // demo hacked
  return authStore.getState().rights;
}

const getTocken = () => { // demo hacked
  return authStore.getState().jwt;
}

const getUsername = () => { // demo hacked
  return authStore.getState().username;
}

const logOut = () => {
  if(authStore.getState().jwt !== "")
    authStore.dispatch({type: "", jwt: ""});
}

export {isLogged, logOut, getRights, getUsername, getTocken}; // demo hacked
