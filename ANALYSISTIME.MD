# Analysis Time

*Note: A significant portion of the "Wall Time" and "Agent Active" time recorded below was spent waiting for the end user to review prompts, approve actions, or respond to questions.*

```text
│  Interaction Summary                                                                                                                                            │
│  Session ID:                 d7fdc6cc-cde2-414e-8ff6-b3cb2227a1ca                                                                                               │
│  Auth Method:                Signed in with Google (jamie@freelygive.org.uk)                                                                                    │
│  Tier:                       Google AI Ultra for Business                                                                                                       │
│  Tool Calls:                 246 ( ✓ 240 x 6 )                                                                                                                  │
│  Success Rate:               97.6%                                                                                                                              │
│  User Agreement:             98.8% (245 reviewed)                                                                                                               │
│  Code Changes:               +1130 -1                                                                                                                           │
│                                                                                                                                                                 │
│  Performance                                                                                                                                                    │
│  Wall Time:                  1h 14m 35s                                                                                                                         │
│  Agent Active:               2h 31m 30s                                                                                                                         │
│    » API Time:               30m 7s (19.9%)                                                                                                                     │
│    » Tool Time:              2h 1m 22s (80.1%)                                                                                                                  │
│                                                                                                                                                                 │
│                                                                                                                                                                 │
│  Model Usage                                                                                                                                                    │
│  Use /model to view model quota information                                                                                                                     │
│                                                                                                                                                                 │
│  Model                           Reqs  Input Tokens   Cache Reads Output Tokens                                                                                 │
│  ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────  │
│  gemini-2.5-flash-lite              2         1,969             0            83                                                                                 │
│    ↳ utility_router                 1         1,032             0            73                                                                                 │
│    ↳ utility_summarizer             1           937             0            10                                                                                 │
│  gemini-3-flash-preview             2        14,870         5,513           125                                                                                 │
│    ↳ main                           2        14,870         5,513           125                                                                                 │
│  gemini-3.1-pro-preview           163     3,164,662     2,084,995        55,932                                                                                 │
│    ↳ main                          42     1,416,653     1,115,918        20,534                                                                                 │
│    ↳ subagent                     121     1,748,009       969,077        35,398 
```
