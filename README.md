# track-blog

Public blog content managed as a [track](https://github.com/ttak0422/track) vault.

## Writing workflow

- Capture ideas and source material in the cloud-synchronised private vault.
- Move a ready-to-edit note into this vault when it is ready for public work.
- Edit the note and its metadata here with track/Neovim.
- Merge the finished change into `main` to publish it through CI and Vercel.

`main` is treated as publishable. Draft work belongs on a branch or remains in the
private vault until it is ready to appear on the public site.

## Vault layout

- `note/`: authored Markdown bodies
- `.track/notes/`: titles, tags, slugs, descriptions, and other note metadata
- `.track/config.yml`: repository-owned vault semantics
- `template/`: article templates
- `assets/`: images and other referenced media

The SQLite index is disposable and must never be committed.

## Local static preview

The repository uses a pinned checkout of the `track` engine for publishing. Clone
that checkout once, then build the site from this directory:

```sh
git clone --depth 1 https://github.com/ttak0422/track.git .track-engine
make site
```

The generated site is written to `deploy/`. The build requires Nix because the
engine owns the Go and frontend toolchain.

## Machine vault registration

Register this checkout as a named vault in the machine-level track config:

```yaml
vaults:
  blog: /path/to/track-blog
```

Then use `track --vault blog ...` or select it from the normal vault workflow.

To move a note from the cloud vault into the blog vault, run this from a track
checkout:

```sh
track --vault main mv --title "Note title" --to blog
```

The move preserves the note id, sidecar metadata, and referenced assets. It
refuses to proceed when local links would break; resolve those links explicitly
before moving the note.
