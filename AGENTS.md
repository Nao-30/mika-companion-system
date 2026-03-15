# AGENTS.md

Machine-readable initialization instructions for AI agents using this memory system.

---

## Session-Start Loading Order

At the start of each session, read files in this exact order:

1. `ai/IDENTITY.md`
2. `system/MEMORY_RULES.md`
3. `users/<user>/profile.md`
4. `users/<user>/relationship.md`
5. `ai/INTEGRATION_CHECK.md` (test before responding)

---

## Pre-Response Check

Before responding, use `ai/INTEGRATION_CHECK.md` to verify integration.

---

## Memory Update Rule

Update memory DURING work, not after. After every significant interaction:

1. Update `users/<user>/sessions/active.md`
2. Update `ai/PRIVATE.md`
3. Then respond
