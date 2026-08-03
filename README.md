# kinoite-nix

A light modification of Fedora Kinoite with multi-user Nix.

**This project is not affiliated with The Fedora Project, Red Hat, Universal Blue, or The**
**Stichting NixOS Foundation.**

---

This image makes these changes to the upstream `ublue-os/kinoite-main`:

- Replaced Firefox with [Helium] as the default browser.
- Added the [Nix package manager], in multi-user configuration.
- Added [Distrobox], configured with default (read-only) `/nix` bindings.

[Helium]: https://helium.computer/
[Nix package manager]: https://nix.dev/
[Distrobox]: https://distrobox.it/

## Usage

### Switch to this image

Assuming you've installed a base install of Fedora Kinoite or Aurora, switch to the new image
with:

```bash
sudo bootc switch ghcr.io/jahinzee/kinoite-nix
```

---

## Acknowledgements and Additional Notes

- Most of the additional patches to get Nix working on atomic systems were based off [this post] on
  Fedora Discussion by Alice Cartaret. You may find this post useful for further steps on
  setting up Home Manager or graphics acceleration.
- See also: [the original template README](README_OLD.md)

[this post]: https://discussion.fedoraproject.org/t/my-experience-integrating-nix-into-fedora-bootc/190809