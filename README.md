# kinoite-nix

A light modification of Fedora Kinoite with multi-user Nix.

This image makes these changes to the upstream `ublue-os/kinoite-main`:

- Replaced Firefox with [Helium] as the default browser.
- Added the [Nix package manager], in multi-user configuration.
- Added [Distrobox].

[Helium]: https://helium.computer/
[Nix package manager]: https://nix.dev/
[Distrobox]: https://distrobox.it/

## Usage

### Switch to this image

Assuming you've installed a base install of Fedora Kinoite or Aurora, you'll need to first
switch to the unsigned version of the image, and reboot.

```bash
sudo bootc switch ghcr.io/jahinzee/kinoite-nix
```

After the reboot, rebase once again to the signed version of the image.

```sh
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/jahinzee/kinoite-nix
```

Reboot again, et voilà!

## Tips, Tricks, and FAQs

### Why Nix, and why not NixOS?

Although the goals of NixOS is really cool, and for some people it's exactly what they're after in
a distro, when it comes to my workstation operating system needs, I care less about perfect
multi-machine reproducibility and more on stability and easy rollback in case of disaster, and
Fedora Atomic already meets my needs in that regard.

The Nix package manager though, theoretically fits really well with the Fedora Atomic model of
applications and their dependencies isolated from the core system, and Nixpkgs being such a wide
ecosystem, between that and Flathub, you can get almost any graphical or command-line app you could
ever need! Of course, in practice there are some roadblocks, but that's why I made this image to
get around them in ways simple package overlaying can't :)

### Why Helium, and why not Firefox?

Helium, as it stands currently, is probably the most no-nonsense browser I've seen while also having
the features as I need in a basic browser. Firefox and Mozilla, meanwhile, seems to be shooting
themselves in the foot multiple times as of late, when it comes of impractical bloat, user privacy,
and actually listening to their community, but that's just my opinion!

Besides, installing Helium with `rpm-ostree` overlays onto a vanilla Fedora Atomic system is
currently impossible, as it needs to write into `/opt` – which is currently unsupported. However,
installing Firefox – either as an overlayed package or through Flatpak – is possible, and if that's
what you personally want, then you're free to do that.

### Can I use Distrobox with my Nix packages?

You can! When creating a distrobox with `distrobox create`, add the `--volume /nix:/nix:ro` flag
for read-only access to your Nix store and apps.

Note that `/nix` will be mounted as **read-only** inside a Distrobox. To perform tasks that modify
`/nix` – i.e. basically anything – you need to run the Nix command-line apps them from the host.

#### Update (2026-08-23):

This function is no longer enabled by default, as it might result in issues with dynamic linking
between libraries installed with the guest OS package manager and libraries installed by Nix.

## Acknowledgements and Additional Notes

- Most of the additional patches to get Nix working on atomic systems were based off [this post] on
  Fedora Discussion by Alice Cartaret. You may find this post useful for further steps on
  setting up Home Manager or graphics acceleration.

- See also: [the original template README](README_OLD.md)

[this post]: https://discussion.fedoraproject.org/t/my-experience-integrating-nix-into-fedora-bootc/190809

---

**This project is not affiliated with The Fedora Project, Red Hat, Universal Blue, or The**
**Stichting NixOS Foundation.**