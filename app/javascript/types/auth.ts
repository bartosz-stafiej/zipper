export type JwtPayload = {
  exp: number,
  user_id: number
}

export type SignInInput = {
  email: string,
  password: string,
}
