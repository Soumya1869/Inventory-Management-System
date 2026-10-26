import { useState, type FormEvent } from "react";

type LoginResponse = {
  jwtToken?: string;
};

const apiBaseUrl = (import.meta.env.VITE_API_BASE_URL || "/api").replace(/\/$/, "");

function BrandMark() {
  return (
    <svg aria-hidden="true" viewBox="0 0 40 40" className="brand-mark">
      <path d="m20 4 15 8.5v15L20 36 5 27.5v-15L20 4Z" fill="none" stroke="currentColor" strokeWidth="1.6" />
      <path d="m5.5 12.8 14.5 8.4 14.5-8.4M20 21.2V35" fill="none" stroke="currentColor" strokeWidth="1.6" />
      <path d="m12.5 8.3 15 8.8v8.4" fill="none" stroke="currentColor" strokeWidth="1.6" opacity=".75" />
    </svg>
  );
}

function EyeIcon({ hidden }: { hidden: boolean }) {
  return hidden ? (
    <svg aria-hidden="true" viewBox="0 0 24 24" className="eye-icon">
      <path d="M3 3l18 18M10.6 10.7a2 2 0 0 0 2.7 2.7M9.9 5.2A10.7 10.7 0 0 1 12 5c5.2 0 8.8 5.2 8.8 7s-1.2 2.8-2.8 4.1M6.2 6.3C3.9 7.8 2.2 10.5 2.2 12c0 1.8 3.6 7 9.8 7 1.3 0 2.5-.3 3.5-.8" fill="none" stroke="currentColor" strokeWidth="1.7" strokeLinecap="round" strokeLinejoin="round" />
    </svg>
  ) : (
    <svg aria-hidden="true" viewBox="0 0 24 24" className="eye-icon">
      <path d="M2.2 12s3.6-7 9.8-7 9.8 5.2 9.8 7-3.6 7-9.8 7-9.8-5.2-9.8-7Z" fill="none" stroke="currentColor" strokeWidth="1.7" />
      <circle cx="12" cy="12" r="3" fill="none" stroke="currentColor" strokeWidth="1.7" />
    </svg>
  );
}

export default function App() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState("");
  const [signedIn, setSignedIn] = useState(false);

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setError("");
    setIsSubmitting(true);

    let response: Response;
    try {
      response = await fetch(`${apiBaseUrl}/auth/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username: username.trim(), password }),
      });
    } catch {
      setError("We couldn't reach the sign-in service. Check your connection and try again.");
      setIsSubmitting(false);
      return;
    }

    if (!response.ok) {
      setError(
        response.status === 401
          ? "That username and password don't match. Try again."
          : "Sign-in is temporarily unavailable. Please try again.",
      );
      setIsSubmitting(false);
      return;
    }

    try {
      const result = (await response.json()) as LoginResponse;
      if (!result.jwtToken) {
        throw new Error("Missing token");
      }

      sessionStorage.setItem("inventory.jwt", result.jwtToken);
      setSignedIn(true);
    } catch {
      setError("We couldn't complete sign-in. Please try again.");
    } finally {
      setIsSubmitting(false);
    }
  }

  function handleSignOut() {
    sessionStorage.removeItem("inventory.jwt");
    setSignedIn(false);
    setPassword("");
  }

  return (
    <main className="login-layout">
      <section className="brand-panel" aria-label="About Stockroom">
        <div className="brand-lockup">
          <BrandMark />
          <div>
            <span className="brand-name">Stockroom</span>
            <span className="brand-caption">INVENTORY WORKSPACE</span>
          </div>
        </div>

        <div className="brand-copy">
          <span className="eyebrow"><span className="eyebrow-dot" /> INVENTORY, IN FOCUS</span>
          <h1>Know what you have.<br /><em>Move with confidence.</em></h1>
          <p>Products, stock, and suppliers come together in one clear workspace.</p>
        </div>

        <div className="box-art" aria-hidden="true">
          <div className="orbit orbit-one" />
          <div className="orbit orbit-two" />
          <div className="box box-back"><span /></div>
          <div className="box box-front"><span /></div>
          <div className="art-label"><span className="art-label-dot" /> EVERY ITEM, ACCOUNTED FOR</div>
        </div>

        <div className="panel-footer">
          <span>STAY IN CONTROL</span>
          <span className="footer-line" />
          <span>01 / 03</span>
        </div>
      </section>

      <section className="form-panel">
        <div className="mobile-brand">
          <BrandMark />
          <span className="brand-name">Stockroom</span>
        </div>

        <div className="login-card">
          {signedIn ? (
            <div className="success-state" role="status">
              <div className="success-mark">
                <svg aria-hidden="true" viewBox="0 0 24 24">
                  <path d="m5 12 4.5 4.5L19 7" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
              </div>
              <span className="form-eyebrow">SESSION READY</span>
              <h2>You're signed in.</h2>
              <p>Your inventory workspace is ready for you.</p>
              <button className="secondary-button" type="button" onClick={handleSignOut}>
                Sign in with another account
              </button>
            </div>
          ) : (
            <>
              <div className="form-heading">
                <span className="form-eyebrow">WELCOME BACK</span>
                <h2>Sign in to Stockroom</h2>
                <p>Enter your account details to continue.</p>
              </div>

              <form className="login-form" onSubmit={handleSubmit}>
                <label className="field-label" htmlFor="username">Username</label>
                <div className="input-wrap">
                  <svg aria-hidden="true" viewBox="0 0 24 24" className="field-icon">
                    <circle cx="12" cy="8" r="3.5" fill="none" stroke="currentColor" strokeWidth="1.6" />
                    <path d="M4.5 20c.6-4 3.2-6 7.5-6s6.9 2 7.5 6" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" />
                  </svg>
                  <input
                    id="username"
                    name="username"
                    type="text"
                    autoComplete="username"
                    placeholder="Your username"
                    value={username}
                    onChange={(event) => setUsername(event.target.value)}
                    required
                  />
                </div>

                <div className="password-label-row">
                  <label className="field-label" htmlFor="password">Password</label>
                </div>
                <div className="input-wrap">
                  <svg aria-hidden="true" viewBox="0 0 24 24" className="field-icon">
                    <rect x="5" y="10" width="14" height="10" rx="2" fill="none" stroke="currentColor" strokeWidth="1.6" />
                    <path d="M8 10V7a4 4 0 0 1 8 0v3" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" />
                  </svg>
                  <input
                    id="password"
                    name="password"
                    type={showPassword ? "text" : "password"}
                    autoComplete="current-password"
                    placeholder="Enter your password"
                    value={password}
                    onChange={(event) => setPassword(event.target.value)}
                    required
                  />
                  <button
                    className="visibility-button"
                    type="button"
                    aria-label={showPassword ? "Hide password" : "Show password"}
                    aria-pressed={showPassword}
                    onClick={() => setShowPassword((visible) => !visible)}
                  >
                    <EyeIcon hidden={showPassword} />
                  </button>
                </div>

                {error && <p className="form-error" role="alert">{error}</p>}

                <button className="primary-button" type="submit" disabled={isSubmitting}>
                  {isSubmitting ? (
                    <><span className="spinner" aria-hidden="true" /> Signing in…</>
                  ) : (
                    <>Sign in <span aria-hidden="true">→</span></>
                  )}
                </button>
              </form>

              <p className="security-note">
                <svg aria-hidden="true" viewBox="0 0 20 20">
                  <path d="M10 2.5 16 5v4.7c0 3.7-2.5 6.1-6 7.8-3.5-1.7-6-4.1-6-7.8V5l6-2.5Z" fill="none" stroke="currentColor" strokeWidth="1.4" />
                  <path d="m7.3 9.8 1.8 1.8 3.7-3.8" fill="none" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" strokeLinejoin="round" />
                </svg>
                Your session is protected.
              </p>
            </>
          )}
        </div>

        <footer className="form-footer">
          <span>© {new Date().getFullYear()} Stockroom</span>
          <span>INVENTORY MANAGEMENT</span>
        </footer>
      </section>
    </main>
  );
}
