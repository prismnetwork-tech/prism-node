# Contributing

Node changes can affect supplier hosts and renter isolation. Open a design
issue before changing privilege boundaries, VFIO handling, egress policy,
signed messages or teardown behavior.

## Workflow

1. Branch from `main`.
2. Add failure-path and negative tests.
3. Update the operator documentation and changelog.
4. Run `./scripts/validate.sh`.
5. Open a focused pull request.

All commits require a Developer Certificate of Origin sign-off:

```sh
git commit --signoff
```

Reviews consider host escape, device isolation, replay resistance, secret
handling, recovery and migration impact.
