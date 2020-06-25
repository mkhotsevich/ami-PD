import React from 'react'
import { Switch, Route } from 'react-router-dom'
import Login from './containers/Login/Login'
import Register from './containers/Register/Register'
import Main from './containers/Main/Main'

const useRoutes = (isAuthenticated, isAdmin) => {
	if (isAuthenticated) {
		if (isAdmin) {
			// return (
			// 	<Switch>
			// 		<Route path={'/'} component={} />
			// 	</Switch>
			// )
		}
		return (
			<Switch>
				<Route path={'/'} component={Main} />
			</Switch>
		)
	}
	return (
		<Switch>
			<Route path={'/login'} component={Login} />
			<Route path={'/register'} component={Register} />
		</Switch>
	)
}

export default useRoutes