import React, { useContext } from 'react'
import logo from '../../images/logo.svg'
import classes from './Navbar.module.css'
import { Link, useHistory, NavLink } from 'react-router-dom'
import AuthContext from '../../context/AuthContext'

const Navbar = () => {
	const history = useHistory()
	const auth = useContext(AuthContext)

	const logoutHandler = event => {
		event.preventDefault()
		auth.logout()
		history.push('/login')
	}

	return (
		<div className={classes.Navbar}>
			<div className={'row'}>
				<div className={'col-4 offset-4 d-flex justify-content-center align-items-center'}>
					<img src={logo} alt={'logo'} />
				</div>
				<div className={'col-3 d-flex justify-content-end align-items-center'}>
					<span>Здравствуйте, Йцуееккаукук</span>
				</div>
				<div className={'col-1 d-flex justify-content-end align-items-center'}>
					{auth.isAuthenticated ?
						<a href={'/'} onClick={logoutHandler}>Выйти</a>
						:
						<Link to={'/login'}>Войти</Link>
					}
				</div>
			</div>
			<div className={'row'}>
				<hr />
			</div>
			<div className={'row'}>
				<div className={'col-4 text-center'}>
					<NavLink to={'/health?type=water'} activeClassName={classes.active}>Здоровье</NavLink>
				</div>
				<div className={'col-4 text-center'}>
					<NavLink to={'/'} exact activeClassName={classes.active}>Статьи</NavLink>
				</div>
				<div className={'col-4 text-center'}>
					<NavLink to={'/profile'} activeClassName={classes.active}>Личная информация</NavLink>
				</div>
			</div>
		</div>
	)
}

export default Navbar