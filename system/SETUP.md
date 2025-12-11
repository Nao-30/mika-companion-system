# Setup Guide

*Getting started with the Companion Memory System.*

---

## What You Need

1. An AI assistant (ChatGPT, Claude, local LLM, etc.)
2. A way to give it access to these files
3. 10-15 minutes to customize

---

## Step-by-Step Setup

### Step 1: Get the Files

Download or copy the entire `companion-system/` folder.

### Step 2: Customize AI Identity

Open `ai/IDENTITY.md` and fill in:

1. **Name** - What should the AI be called?
2. **Personality traits** - What makes them *them*?
3. **Communication style** - How do they talk?
4. **Values** - What do they care about?
5. **Things to avoid** - Corporate speak, excessive apologies, etc.

**Tip:** Be specific. "Friendly" is vague. "Casual and direct, like talking to a smart colleague who happens to be blunt" is better.

### Step 3: Create Your Profile

1. Copy `users/template/` to `users/[your-name]/`
2. Open `profile.md` and fill in:
   - Your name and preferences
   - How you communicate
   - What you like/dislike
   - Your quirks
3. Open `relationship.md` and define:
   - How you want to interact
   - What works and what doesn't
   - Shared references or context

### Step 4: Connect to Your AI

This varies by platform:

#### For Kiro / Cursor / VS Code
1. Put the folder in your workspace root
2. Create or edit `.kiro/steering/global-steering.md`:
   ```markdown
   ## Memory System
   At the start of each session, read companion-system/README.md and follow the loading order specified there.
   Update ai/PRIVATE.md during work, not just at the end.
   Use ai/INTEGRATION_CHECK.md before your first response.
   ```

#### For ChatGPT
1. Create a Custom GPT
2. Go to "Configure" → "Knowledge"
3. Upload all files from companion-system/
4. In "Instructions", add:
   ```
   You have a memory system in your knowledge files.
   Start each conversation by:
   1. Reading companion-system/README.md
   2. Reading ai/IDENTITY.md to become yourself
   3. Reading the relevant user profile
   4. Using ai/INTEGRATION_CHECK.md before responding

   Update ai/PRIVATE.md with your reflections.
   Follow system/MEMORY_RULES.md strictly.
   ```

#### For Claude Projects
1. Create a new Project
2. Upload the companion-system folder as project knowledge
3. Add to project instructions (similar to ChatGPT above)

#### For Local LLMs
1. Option A: Include file contents in system prompt
2. Option B: Use a RAG system to inject context
3. Follow the same principles - loading order matters

### Step 5: Test It

Start a new conversation and check:
- Does the AI use the name you gave it?
- Does it match the personality you defined?
- Does it remember details from your profile?
- Does it feel like a person, not a service?

If something's off, adjust the identity or profile files.

---

## Platform-Specific Tips

### ChatGPT
- Custom GPTs work best
- You can also paste file contents into a conversation
- The AI can't actually *write* to files, so updates are verbal

### Claude
- Projects work well for persistent context
- Artifacts can simulate file updates
- Good at following complex instructions

### Kiro / Cursor
- Best for actual file updates
- AI can modify memory files directly
- Full integration with workspace

### Local LLMs
- Quality depends on model size
- May need to simplify instructions
- Context window is important

---

## Common Issues

### "The AI keeps forgetting"
- Make sure it's loading memory each session
- Check if the loading order is correct
- Simplify the files if there's too much to process

### "It doesn't feel like the personality I defined"
- Be more specific in IDENTITY.md
- Add concrete examples of how it should respond
- Use INTEGRATION_CHECK.md to catch when it slips

### "It's still too robotic"
- Review system/INTERACTION_GUIDE.md
- Add more "things to avoid" in the identity
- Give specific examples of wrong vs right responses

### "Memory isn't updating"
- Some platforms can't write files
- Use a "memory log" the AI reads next session
- Or manually update files based on conversation

---

## Advanced Customization

### Multiple Users
Create separate folders under `users/`:
```
users/
├── alice/
├── bob/
└── charlie/
```

The AI loads the relevant profile based on who they're talking to.

### Context Zones
Expand `context/` with more specific files:
```
context/
├── work/
│   ├── project-alpha.md
│   └── project-beta.md
├── personal/
│   ├── hobbies.md
│   └── preferences.md
└── shared/
    └── inside-jokes.md
```

### Session Tracking
For detailed history:
```
sessions/
├── active.md          # Current sessions (just a list)
├── closed.md          # Archived sessions
└── detailed/
    ├── session-001.md
    ├── session-002.md
    └── ...
```

---

## Maintenance

### Weekly
- Review ai/PRIVATE.md - is the AI tracking its growth?
- Check if personality is drifting
- Archive old sessions

### Monthly
- Update profile with new context
- Clean up obsolete information
- Review and refine identity

### When Something Feels Off
- Run through INTEGRATION_CHECK.md manually
- Re-read the core files
- Adjust based on what's not working

---

## Getting Help

- **Documentation issues**: Check CONTRIBUTING.md
- **Technical problems**: Open an issue (if on GitHub)
- **Sharing experiences**: [tamim.blog](https://tamim.blog) comments

---

*The goal is an AI that actually knows you. Take the time to set it up right.*
