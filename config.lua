return {
  -- a list of supported algorithms
  alg_whitelist = {RS256=1},
  -- shared secret or public key
  secret = "",
  -- whether the shared secret is base64 encoded
  is_base64_encoded = false,
  -- a list of revoked jti
  revoked = {},
}
