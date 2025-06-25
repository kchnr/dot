# TypeScript & Code Style Guidelines

## 1. any Inside Generic Functions  
When building generic functions, you may need to use `any` inside the function body. This is because TypeScript often cannot match your runtime logic to the logic done inside your types.

```ts
const youSayGoodbyeISayHello = <
  TInput extends "hello" | "goodbye",
>(
  input: TInput,
): TInput extends "hello" ? "goodbye" : "hello" => {
  if (input === "goodbye") {
    return "hello" as any;
  } else {
    return "goodbye" as any;
  }
};
````

Outside of generic functions, use `any` extremely sparingly.

---

## 2. Default Exports

Unless explicitly required by the framework, do not use default exports.

```ts
// BAD
export default function myFunction() {
  return <div>Hello</div>;
}

// GOOD
export function myFunction() {
  return <div>Hello</div>;
}

// BAD import
import myFunction from "./myFunction";

// GOOD import
import { myFunction } from "./myFunction";
```

> *Exception:* Framework pages (e.g. Next.js) that require a default export are fine.

---

## 3. Discriminated Unions

Proactively use discriminated unions to model data that can be in one of a few shapes, and prevent impossible states.

```ts
type UserCreatedEvent = {
  type: "user.created";
  data: { id: string; email: string };
};
type UserDeletedEvent = {
  type: "user.deleted";
  data: { id: string };
};
type Event = UserCreatedEvent | UserDeletedEvent;
```

Handle via `switch`:

```ts
const handleEvent = (event: Event) => {
  switch (event.type) {
    case "user.created":
      console.log(event.data.email);
      break;
    case "user.deleted":
      console.log(event.data.id);
      break;
  }
};
```

Fetch state example—avoid “bag of optionals”:

```ts
// BAD
type FetchingState<TData> = {
  status: "idle" | "loading" | "success" | "error";
  data?: TData;
  error?: Error;
};

// GOOD
type FetchingState<TData> =
  | { status: "idle" }
  | { status: "loading" }
  | { status: "success"; data: TData }
  | { status: "error"; error: Error };
```

---

## 4. Enums

Do not introduce new `enum`s—retain existing ones. For enum-like behavior, use `as const` objects:

```ts
const backendToFrontendEnum = {
  xs: "EXTRA_SMALL",
  sm: "SMALL",
  md: "MEDIUM",
} as const;

type LowerCaseEnum = keyof typeof backendToFrontendEnum; // "xs" | "sm" | "md"
type UpperCaseEnum =
  (typeof backendToFrontendEnum)[LowerCaseEnum]; // "EXTRA_SMALL" | "SMALL" | "MEDIUM"
```

> Numeric enums create reverse mappings (double keys), so prefer `as const` for most cases.

---

## 5. import type

Use top-level `import type` whenever importing types.

```ts
// BAD
import { type User } from "./user";

// GOOD
import type { User } from "./user";
```

Inline `import { type … }` may leave stray runtime imports after transpilation.

---

## 6. Installing Libraries

Do not hard-code versions from your training data. Install the latest via your package manager:

```bash
# pnpm
pnpm add -D @typescript-eslint/eslint-plugin

# yarn
yarn add -D @typescript-eslint/eslint-plugin

# npm
npm install --save-dev @typescript-eslint/eslint-plugin
```

---

## 7. interface extends vs &

Always prefer `interface` inheritance over `&` types.

```ts
// BAD
type A = { a: string };
type B = { b: string };
type C = A & B;

// GOOD
interface A { a: string }
interface B { b: string }
interface C extends A, B { /* add more props */ }
```

---

## 8. JSDoc Comments

Use JSDoc for non-obvious behaviors or types, and link internally with `@link`.

```ts
/**
 * Subtracts two numbers
 */
const subtract = (a: number, b: number) => a - b;

/**
 * Does the opposite to {@link subtract}
 */
const add = (a: number, b: number) => a + b;
```

---

## 9. Naming Conventions

* **Files**: kebab-case (`my-component.ts`)
* **Variables/Functions**: camelCase (`myVariable`, `myFunction()`)
* **Classes/Types/Interfaces**: PascalCase (`MyClass`, `MyInterface`)
* **Constants/Enum Values**: ALL\_CAPS (`MAX_COUNT`, `Color.RED`)
* **Type Parameters**: Prefix with `T` (`TKey`, `TValue`)

```ts
type RecordOfArrays<TItem> = Record<string, TItem[]>;
```

---

## 10. noUncheckedIndexedAccess

Be aware that enabling `noUncheckedIndexedAccess` makes `obj[key]` and `arr[0]` yield `T | undefined`.

---

## 11. Optional Properties

Use optional properties only when truly optional. Otherwise, prefer explicit `T | undefined`.

```ts
// BAD
type AuthOptions = { userId?: string };

// GOOD
type AuthOptions = { userId: string | undefined };
```

---

## 12. Readonly Properties

Default to `readonly` on object types to prevent accidental mutation.

```ts
// BAD
type User = { id: string };

// GOOD
type User = { readonly id: string };
```

---

## 13. Return Types

Declare return types on top-level functions to aid tooling. Exception: JSX-returning components.

```ts
const myFunc = (): string => "hello";
const MyComponent = () => <div>Hello</div>;
```

---

## 14. Throwing vs Result Types

Think before throwing. If callers would need `try/catch`, prefer a `Result` type:

```ts
type Result<T, E extends Error> =
  | { ok: true; value: T }
  | { ok: false; error: E };

const parseJson = (input: string): Result<unknown, Error> => {
  try {
    return { ok: true, value: JSON.parse(input) };
  } catch (error) {
    return { ok: false, error: error as Error };
  }
};
```

Handle errors explicitly instead of uncontrolled exceptions.
